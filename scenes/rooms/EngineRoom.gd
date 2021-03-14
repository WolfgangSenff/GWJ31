extends "res://scenes/RoomBase.gd"


func _on_SpinBox_value_changed(value: float) -> void:
    room_activated("target-self", { "action" : "update-power", "power" : value })
