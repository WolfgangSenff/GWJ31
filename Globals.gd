extends Node

func CameraZoomOut(for_time) -> void:
    var tree = get_tree()
    var camera = tree.get_nodes_in_group("Camera")[0]
    camera.zoom_out(for_time)
