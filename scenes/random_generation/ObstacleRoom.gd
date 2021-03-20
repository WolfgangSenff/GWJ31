extends RigidBody2D

export (Vector2) onready var RoomSize
export (Resource) onready var ObstacleRes

onready var collision_shape = $CollisionShape2D

func place_obstacle_in_galaxy() -> void:
    Globals.SpawnOnMain(ObstacleRes.ObstacleScene, global_position, 0)
    collision_shape.set_deferred("disabled", true)

func set_full_room_size(extra_size : Vector2) -> void:
    RoomSize += (extra_size * 2)
    collision_shape.shape = collision_shape.shape.duplicate()
    collision_shape.shape.extents = RoomSize
