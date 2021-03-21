extends RigidBody2D

func place_obstacle_in_galaxy(obstacle_res) -> void:
    Globals.SpawnOnMain(obstacle_res.ObstacleScene, global_position, 0)
    $CollisionShape2D.set_deferred("disabled", true)

func set_room_size(room_size : float) -> void:
    $CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
    $CollisionShape2D.shape.extents = Vector2.ONE * room_size

