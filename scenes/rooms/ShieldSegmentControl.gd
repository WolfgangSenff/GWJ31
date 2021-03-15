extends Area2D

var lit = true
var charge = 0
onready var overload = Timer.new()

#this is ugly and wrong but is how I can get it working fast
onready var room = get_parent().get_parent().get_parent()

func _ready():
	connect("area_entered", self, "_on_body_entered")
	
func _on_body_entered(area):
	if area.is_in_group("weapon") and lit == true:
		charge += area.Damage
		if charge >= room.shieldCap:
			lit = !lit
			get_node("CollisionShape2D").disabled = !lit
			overload.connect("timeout", self, "cooled")
			overload.one_shot = true
			overload.start(15)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed() \
	and room.power == true:
		lit = !lit

func cooled():
	lit = !lit
	get_node("CollisionShape2D").disabled = !lit
