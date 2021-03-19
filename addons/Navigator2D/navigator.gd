tool
extends Node2D

signal on_destination_reached(navigator, position)
signal on_moved(direction)

export (float) var NavigationStopEpsilon = 5
export (float) var Speed = 50
export (bool) var OptimizePath = false
export (bool) var LookAt = true
var motion = Vector2(0, 0)

var actor
var path
var current_destination
var next_destination
var navigation
var is_navigating

func navigate_to(destination):
    if actor and is_instance_valid(actor) and actor.position:
        current_destination = destination
        path = navigation.get_simple_path(actor.position, current_destination, OptimizePath)
        is_navigating = true

func navigate(delta):
    if actor and is_instance_valid(actor):
        var distance_to_destination = actor.position.distance_to(path[0])
        next_destination = path[0]
        var normalized_direction = (next_destination - actor.position)
        emit_signal("on_moved", normalized_direction.normalized())
        if distance_to_destination > NavigationStopEpsilon:
            move(delta)
        else:
            update_path()
    else:
        emit_signal("on_destination_reached", self, current_destination)

func move(delta):
    assert(actor)
    if LookAt:
        actor.look_at(next_destination)
    var normalized_direction = (next_destination - actor.position).normalized()
    var speed = normalized_direction * Speed
    if actor is KinematicBody2D:
        actor.move_and_slide(speed)
    else:
        motion = speed * delta
        actor.position += motion
    
func update_path():
    assert(actor)
    if path.size() == 1:
        is_navigating = false
        emit_signal("on_destination_reached", self, current_destination)
    else:
        path.remove(0)

func _physics_process(delta):
    if is_navigating:
        navigate(delta)
        
func _enter_tree():
    actor = get_parent()
