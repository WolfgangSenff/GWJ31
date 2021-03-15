extends Node

func CameraZoomOut(for_time) -> void:
    var tree = get_tree()
    var camera = tree.get_nodes_in_group("Camera")[0]
    camera.zoom_out(for_time)

func SpawnOnMain(toSpawn : PackedScene, pos : Vector2, rot : float, shouldEnablePhysics : bool = false):
    var scene = toSpawn.instance()
    get_tree().root.add_child(scene)
    scene.global_position = pos
    scene.global_rotation = rot
    if shouldEnablePhysics:
        scene.call_deferred("set_physics_process", shouldEnablePhysics)
        
    return scene
