extends Node2D

onready var _room_outline = $"RoomOutline-maybe-shader"

func _show_mouse_outline() -> void:
	_room_outline.show()
	
func _hide_mouse_outline() -> void:
	_room_outline.hide()
