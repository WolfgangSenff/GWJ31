extends Node2D

# Put data here for the overall ship.
#  Export it mostly and then we can have different values per ship.

export(int) var commsRange = 0 
export(int) var food = 0
export(int) var fuel = 0
export(int) var medicines = 0
export(int) var integrity = 0
export(int) var shield_x = 0
export(int) var shield_y = 0
var topSpeed = 0 #may need to be passed to the engines

export (bool) var enemyControlled

onready var _finish_popup = $CanvasLayer/ActivationPopup/MainContainer/ContentContainer/CenterContainer/VBoxContainer

# Each of the rooms will signal up to the ShipBase when changes
#  in status have to occur based on the room.

# When an attack happens on the ship, it will occur here and
#  we'll call down to the appropriate room to take the damage
#  however it will happen.

func _ready() -> void:
	var rooms = $Rooms
	for room in rooms.get_children():
		room.connect("room_activated", self, "_on_room_activated")

func set_camera(camera : Camera2D) -> void:
	$CameraTransform.remote_path = camera.get_path()

func _on_room_activated(room, command, data) -> void:
	handle_room_activation(room, command, data)

func handle_room_activation(room, command, data) -> void:
	# This handles the brunt of the work; when a room is
	#  activated, this function will read the command,
	#  interpret it, and apply the values in data
	#  accordingly.
	#room_activated("target-enemy", { "damage" : Damage, "effects" : [], "scene" : Projectile, "fire_position" : $FirePosition.global_position, "fire_rotation" })
	
	match command:
		"target-enemy":
			var scene = Globals.SpawnOnMain(data["scene"], data["fire_position"], data["fire_rotation"], true)
		"trade":
			update_cargo(data["trading"])
		"connect":
			pass
	
func handle_obstacle(obstacle, command, data) -> void:
	# Same as above, but for obstacles. This is called
	#  from the galaxy directly
	pass
	
func update_cargo(goodsTraded):
	var earn = Label.new()
	earn.text = "you got " + str(goodsTraded.give_quantity) + " " + goodsTraded.give
	_finish_popup.add_child(earn)
	var expend = Label.new()
	expend.text = "for " + str(goodsTraded.take_quantity) + " " + goodsTraded.take
	_finish_popup.add_child(expend)
	var close = Button.new()
	close.text = "close"
	close.connect("pressed", self, "close")
	_finish_popup.add_child(close)
	$CanvasLayer/ActivationPopup.popup_centered_ratio(.8)
	
func close():
	$CanvasLayer/ActivationPopup.hide()
	for i in _finish_popup.get_children():
		_finish_popup.remove_child(i)
		i.queue_free()
