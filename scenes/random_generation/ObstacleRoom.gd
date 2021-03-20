extends RigidBody2D

export (Resource) onready var ObstacleRes

onready var collision_shape = $CollisionShape2D

func _ready() -> void:
    set_room_size(ObstacleRes.ObstacleSize)

func place_obstacle_in_galaxy() -> void:
    Globals.SpawnOnMain(ObstacleRes.ObstacleScene, global_position, 0)
    collision_shape.set_deferred("disabled", true)

func set_room_size(room_size : float) -> void:
    collision_shape.shape = collision_shape.shape.duplicate()
    collision_shape.shape.extents = room_size
