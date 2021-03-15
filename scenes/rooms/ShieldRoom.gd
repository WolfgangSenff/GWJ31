extends "res://scenes/RoomBase.gd"

export(Vector2) var shield_pos
var power = true

onready var button = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer/CenterContainer/Button

func _ready():
	$Shield.position = shield_pos




func _on_Button_pressed():
	if power == true:
		button.text = "Turn On"
		power = false
	else:
		button.text = "Turn Off"
		power = true
