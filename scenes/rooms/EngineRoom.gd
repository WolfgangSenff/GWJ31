extends "res://scenes/RoomBase.gd"


func _on_SpinBox_value_changed(value: float) -> void:
	if value < 20 and value > -20:
		value = 0
	room_activated("target-self", { "action" : "update-power", "power" : value })
