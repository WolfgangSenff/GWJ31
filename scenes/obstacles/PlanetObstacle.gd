extends "res://scenes/ObstacleBase.gd"

onready var sprite = $ObstacleUnderlying

const MinMovementSpeed = 50
const MaxMovementSpeed = 300

var direction
var speed

func _ready() -> void:
    sprite.texture = PlanetTextures.all_planet_textures.all_resources[randi() % PlanetTextures.all_planet_textures.all_resources.size()]
    direction = randi() % 360
    speed = MinMovementSpeed + (randi() % MaxMovementSpeed - randi() % MinMovementSpeed)
    
func _physics_process(delta : float) -> void:
    global_position += Vector2.RIGHT.rotated(direction) * speed * delta
