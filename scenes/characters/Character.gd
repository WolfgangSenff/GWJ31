extends Area2D

onready var navigator = $Navigator2D

export (String) var CharacterName

var _character_selected = false

func _on_Character_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
#	if event is InputEventMouseButton:
#		print(event)
#		_character_selected = event.is_pressed()
#		if !_character_selected:
#			navigator.is_navigating = false
#			yield(get_tree(), "idle_frame")
#			navigator.navigate_to(event.global_position - get_parent().get_parent().global_position)
#		else:
#			character_activated()
	pass
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		print(get_global_mouse_position())
		if _character_selected:
			var transform = Transform2D()
			navigator.is_navigating = false
			yield(get_tree(), "idle_frame")
			navigator.navigate_to(get_global_mouse_position() - get_parent().global_position)
		else:
			character_activated()


func character_activated() -> void:
	pass
