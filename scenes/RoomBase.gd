extends Node2D

signal room_activated(room, command, data)

onready var _room_outline = $"RoomOutline-maybe-shader"
onready var _activation_popup = $CanvasLayer/ActivationPopup
# Notice the above is not exclusive so the player can tap
#  outside the view to close it, in which case nothing should
#  happen
onready var content_container = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer

export (String) var RoomId # Use this to target specific rooms with specific obstacles

var room_open = false
var has_character = false
var _current_character_count = 0
var actions_enabled = true

signal hit(damage)
signal death

func _ready() -> void:
	_activation_popup.connect("about_to_show", self, "_on_about_to_show_popup")
	_activation_popup.connect("popup_hide", self, "_on_popup_hide")
	$CharacterArea/CollisionShape2D.shape.extents = $RoomHover/CollisionShape2D.shape.extents

func _on_about_to_show_popup() -> void:
	room_open = true

func _on_popup_hide() -> void:
	room_open = false

func _show_mouse_outline() -> void:
	_room_outline.show()
	
func _hide_mouse_outline() -> void:
	_room_outline.hide()

func _room_input(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if actions_enabled:
			var other_rooms = get_tree().get_nodes_in_group("Room")
			for room in other_rooms:
				if room != self and room.room_open:
					return
					
			_handle_mouse_input()
		else:
			var characters = get_tree().get_nodes_in_group("Character")
			for character in characters:
				if character._character_selected:
					character.navigator.navigate_to(event.global_position)
					get_tree().call_group("Room", "enable_actions")
					get_tree().set_group("CharacterSelectButton", "pressed", false)
					break

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

func disable_actions() -> void:
	actions_enabled = false
	
func enable_actions() -> void:
	actions_enabled = true

func character_entered() -> void:
	pass

func character_exited() -> void:
	pass

func _on_CharacterArea_area_entered(area: Area2D) -> void:
	_current_character_count += 1
	has_character = true
	character_entered()

func _on_CharacterArea_area_exited(area: Area2D) -> void:
	_current_character_count -= 1
	if _current_character_count <= 0:
		has_character = false
		
	character_exited()

func _on_RoomHover_area_entered(area):
	if area.is_in_group("weapon"):
		if area.armed == true:
			area.set_physics_process(false)
			area.explode()
			get_parent().get_parent().integrity -= area.Damage
			emit_signal("hit", get_parent().get_parent().integrity)
			if get_parent().get_parent().integrity == 0:
				emit_signal("death")
