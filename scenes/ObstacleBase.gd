extends Node2D

# Presumably this takes some functionality and points to the ship
# When something happens (say the obstacle is a blackhole and
#  the ship gets too close), the obstacle is responsible for
#  modifying the ship/damaging it/whatever

export (String) var StarbaseName

onready var _trader_popup = $CanvasLayer/Popup

func _on_Area2D_area_entered(area: Area2D) -> void:
    get_tree().call_group("Playable", "close_all_room_popups")
    _trader_popup.popup_centered_ratio(.90)
    get_tree().paused = true

func _on_Popup_popup_hide() -> void:
    get_tree().paused = false
