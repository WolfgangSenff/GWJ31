extends "res://scenes/ObstacleBase.gd"

var rotation_speed
var linear_speed
var should_travel_at_rotation_angle
var travel_angle

func _ready() -> void:
    rotation_speed = randf() * 5
    linear_speed = randi() % 200
    travel_angle = deg2rad(randi() % 360)
    should_travel_at_rotation_angle = randi() % 4 == 0

func _physics_process(delta : float) -> void:
    rotation += delta * rotation_speed
    var position_travel_vector = Vector2.RIGHT.rotated(rotation if should_travel_at_rotation_angle else travel_angle)
    position += delta * linear_speed * position_travel_vector

func _on_Area2D_area_entered(area: Area2D) -> void:
    var expl = Globals.SpawnOnMain(preload("res://scenes/Explosion.tscn"), global_position, rotation)
    expl.emitting = true
    Globals.SpawnSpiceJars(global_position)
    sprite.hide()
    set_physics_process(false) # may need to defer this
    yield(get_tree().create_timer(3.0), "timeout")
    queue_free()
