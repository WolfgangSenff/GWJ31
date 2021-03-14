extends "res://scenes/RoomBase.gd"

onready var _comms_dialog = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer/CenterContainer/VBoxContainer

export (int) var sensorRange
var openComms = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CommsRange/CollisionShape2D.shape.radius = sensorRange

func _on_CommsRange_area_entered(area):
	openComms = true
	$AnimationPlayer.seek(0, true)
	$AnimationPlayer.play("Flashing")


func _on_CommsRange_area_exited(area):
	openComms = false
	$AnimationPlayer.stop()
	$AnimationPlayer.seek(1, true)
	
func updateSensor(newRange):
	sensorRange = newRange
	$CommsRange/CollisionShape2D.shape.radius = sensorRange
	
func _handle_mouse_input():
	if openComms == true:
		._handle_mouse_input()
		var label = Label.new()
		label.text = "surrender or fight"
		var fight = Button.new()
		fight.text = "fight"
		fight.connect("pressed", self, "quit")
		var surrender = Button.new()
		surrender.text = "surrender"
		surrender.connect("pressed", self, "quit")
		_comms_dialog.add_child(label)
		_comms_dialog.add_child(fight)
		_comms_dialog.add_child(surrender)

func quit():
	_activation_popup.hide()
	for i in _comms_dialog.get_children():
		_comms_dialog.remove_child(i)
		i.queue_free()
