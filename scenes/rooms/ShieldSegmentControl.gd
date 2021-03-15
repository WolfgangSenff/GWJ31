extends Area2D

var lit = true

onready var room = get_parent().get_parent().get_parent()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed() \
	and room.power == true:
		lit = 1 - int(lit)
