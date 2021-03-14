extends Node2D

signal room_activated(room, command, data)

onready var _room_outline = $"RoomOutline-maybe-shader"
onready var _activation_popup = $CanvasLayer/ActivationPopup
# Notice the above is not exclusive so the player can tap
#  outside the view to close it, in which case nothing should
#  happen
onready var content_container = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer

export (String) var RoomId # Use this to target specific rooms with specific obstacles

func _show_mouse_outline() -> void:
	_room_outline.show()
	
func _hide_mouse_outline() -> void:
	_room_outline.hide()

func _room_input(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_handle_mouse_input()

# When the room is extended, override this to handle what happens.
#  The default for now is to show the ActivationPopup
func _handle_mouse_input():
	_activation_popup.popup_centered_ratio(.8)
	# Chose .8 for no real reason
	

# Emit room_activated when this room actually executes its command,
#  so like the Helm would emit the signal when the player changes
#  the direction the ship is going

func room_activated(command, data) -> void:
	emit_signal("room_activated", self, command, data)
	# All this does is emits the signal; however, individual
	#  rooms should call this when needed
