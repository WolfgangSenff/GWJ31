extends Area2D

var lit = true
var charge = 0
var state = "cooled"
onready var overload : Timer

#this is ugly and wrong but is how I can get it working fast
onready var room = get_parent().get_parent().get_parent()

func _ready():
    overload = Timer.new()
    add_child(overload)
    connect("area_entered", self, "_on_body_entered")
    
func _on_body_entered(area):
    if area.is_in_group("weapon") and lit == true:
        charge += area.Damage
        area.set_physics_process(false)
        area.explode()
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
    and room.power == true and !get_node("CollisionShape2D").disabled \
    and !get_parent().get_parent().get_parent().get_parent().get_parent().enemyControlled:
        lit = !lit

func cooled():
    lit = !lit
    state = "cooled"
    get_node("CollisionShape2D").disabled = !lit
    
func _process(delta):
    if charge <= room.shieldCap * 0.5:
        state = "cooled"
    if charge >= room.shieldCap * 0.5:
        state = "hot"
    if charge >= room.shieldCap * 0.75:
        state = "overcharge"
        
    if !lit:
        charge -= 2 * delta
        
    charge = clamp(charge, 0, room.shieldCap)
