extends "res://scenes/RoomBase.gd"

var _captured_steering_wheel = false
onready var _steering_wheel = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer/CenterContainer/ViewportContainer/Viewport/SteeringBase/SteeringArea
onready var _steering_base = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer/CenterContainer/ViewportContainer/Viewport/SteeringBase

func _on_SteeringArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        _captured_steering_wheel = event.is_pressed()
        if !_captured_steering_wheel:
            room_activated("target-self", { "action" : "update-steering", "steering" : _steering_wheel.position.x })
    
    if event is InputEventMouseMotion and _captured_steering_wheel:
        _steering_wheel.position.x += event.relative.x
        _steering_wheel.position.x = clamp(_steering_wheel.position.x, -55.0, 55.0)
    
