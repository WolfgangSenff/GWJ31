extends "res://scenes/ObstacleBase.gd"

var rotation_speed
var linear_speed
var should_travel_at_rotation_angle
var travel_angle

func _ready() -> void:
    rotation_speed = randf() / 2.0
    linear_speed = randi() % 400

func _physics_process(delta : float) -> void:
    rotation += delta * rotation_speed
    position += delta * linear_speed * Vector2.RIGHT.rotated(rotation)

func _on_Area2D_area_entered(area: Area2D) -> void:
    var expl = Globals.SpawnOnMain(preload("res://scenes/Explosion.tscn"), global_position, rotation)
    expl.emitting = true
    Globals.SpawnSpiceJars(global_position)
    sprite.hide()
    set_physics_process(false) # may need to defer this
    yield(get_tree().create_timer(3.0), "timeout")
    queue_free()
