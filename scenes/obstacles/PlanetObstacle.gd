extends "res://scenes/ObstacleBase.gd"

const MinMovementSpeed = 50
const MaxMovementSpeed = 300

var direction
var speed

func _ready() -> void:
    set_physics_process(false)
    var all_text_res = PlanetTextures.all_planet_textures
    var all_res = all_text_res.all_resources
    var size = all_res.size()
    sprite.texture = PlanetTextures.all_planet_textures.all_resources[randi() % PlanetTextures.all_planet_textures.all_resources.size()]
    direction = randi() % 360
    speed = MinMovementSpeed + (randi() % MaxMovementSpeed - randi() % MinMovementSpeed)
    set_physics_process(true)
    
func _physics_process(delta : float) -> void:
    global_position += Vector2.RIGHT.rotated(direction) * speed * delta
