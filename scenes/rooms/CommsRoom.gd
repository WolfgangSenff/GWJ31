extends "res://scenes/RoomBase.gd"

onready var _comms_dialog = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer/CenterContainer/VBoxContainer

export (int) var sensorRange
var openComms = false

var messageSend = {
	"intentions" : "trade",
	"text" : "I would like to trade",
	"trading" : {
		"give" : "fuel",
		"give_quantity" : 20,
		"take" : "spice",
		"take_quantity" : 20,
	}
}
var _message_owner

signal traded(goodsTraded, source)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CommsRange/CollisionShape2D.shape.radius = sensorRange

func _on_CommsRange_area_entered(area):
	openComms = true
	$AnimationPlayer.seek(0, true)
	$AnimationPlayer.play("Flashing")
	_message_owner = area.get_parent()


func _on_CommsRange_area_exited(area):
	openComms = false
	$AnimationPlayer.stop()
	$AnimationPlayer.seek(1, true)
	_message_owner = null
	
func update_sensor(newRange):
	sensorRange = newRange
	$CommsRange/CollisionShape2D.shape.radius = sensorRange
	
func _handle_mouse_input():
	pass
		
func quit():
	_activation_popup.hide()
	for i in _comms_dialog.get_children():
		_comms_dialog.remove_child(i)
		i.queue_free()
		
func trade():
	quit()
	emit_signal("traded", _message_owner.messageSend.trading, self)
	

func parse_message(message):
	add_text(message.text)
	
	if message.intentions == "hostile":
		make_answer("Fight", "quit")
		make_answer("Surrender", "quit")
	if message.intentions == "trade":
		make_answer("Accept Offer", "trade")
		make_answer("Decline Offer", "quit")
		

func add_text(text):
	var label = Label.new()
	label.text = text
	_comms_dialog.add_child(label)
	
func make_answer(text, action):
	var button = Button.new()
	button.text = text
	button.connect("pressed", self, action)
	_comms_dialog.add_child(button)
