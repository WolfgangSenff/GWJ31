tool
extends EditorPlugin

func _enter_tree():
    add_custom_type("Navigator2D", "Node2D", preload("navigator.gd"), preload("navigator_icon.png"))

func _exit_tree():
    remove_custom_type("Navigator2D")
