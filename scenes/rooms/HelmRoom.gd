extends "res://scenes/RoomBase.gd"

func _on_HSlider_value_changed(value: float) -> void:
    room_activated("target-self", { "action" : "update-steering", "steering" : value })
