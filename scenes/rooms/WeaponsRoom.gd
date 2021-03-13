extends "res://scenes/RoomBase.gd"

onready var _button_timer = $CircularTimedProgress

export (int) var Damage
export (PackedScene) var Projectile

func _handle_mouse_input():
    if _button_timer.is_ready:
        ._handle_mouse_input()

func _on_activation_button_pressed() -> void:
    _button_timer.begin_refresh()
    _activation_popup.hide()
    Globals.CameraZoomOut(3)
    room_activated("target-enemy", { "damage" : Damage, "effects" : [], "target" : "random-room", "projectile" : Projectile, "fire_position" : $FirePosition.global_position })
