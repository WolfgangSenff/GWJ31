extends Node

signal game_over
signal spice_picked_up
signal exit_open

var selectedShip: String

const SpiceJarScene = preload("res://scenes/collectables/SpiceJar.tscn")

func CameraZoomOut(for_time) -> void:
	var tree = get_tree()
	var camera = tree.get_nodes_in_group("Camera")[0]
	camera.zoom_out(for_time)

func SpawnOnMain(toSpawn : PackedScene, pos : Vector2, rot : float, shouldEnablePhysics : bool = false):
    var scene = toSpawn.instance()
    get_tree().root.get_node("Galaxy").add_child(scene)
    scene.global_position = pos
    scene.global_rotation = rot
    if shouldEnablePhysics:
        scene.call_deferred("set_physics_process", shouldEnablePhysics)
    return scene

func SpawnSpiceJars(posit) -> void:
    for i in randi() % 10:
        SpawnOnMain(SpiceJarScene, posit, deg2rad(randi() % 360))
