extends "res://scenes/ObstacleBase.gd"


onready var _trader_popup = $CanvasLayer/Control/Popup

func _on_Area2D_area_entered(area: Area2D) -> void:
    get_tree().call_group("Playable", "close_all_room_popups")
    _trader_popup.popup_centered_ratio(.90)
    get_tree().paused = true

func _on_Popup_popup_hide() -> void:
    get_tree().paused = false
