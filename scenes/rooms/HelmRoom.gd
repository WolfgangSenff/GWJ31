extends "res://scenes/RoomBase.gd"

func _on_HSlider_value_changed(value: float) -> void:
	if value < 5 and value > -5:
		value = 0
	room_activated("target-self", { "action" : "update-steering", "steering" : value })
