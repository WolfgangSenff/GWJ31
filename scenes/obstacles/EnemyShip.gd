extends "res://scenes/ObstacleBase.gd"

onready var ship_images = [
    preload("res://sprites/ship2-closed.png"),
    preload("res://sprites/ship3-closed.png"),
    preload("res://sprites/ship4-closed.png"),
    preload("res://sprites/ship5-closed.png")
   ]

onready var timer = $Timer

var all_starbases setget , get_all_starbases
var current_starbase = null
var current_direction = Vector2.ZERO
var movement_speed = 0

func _ready() -> void:
    sprite.texture = ship_images[randi() % ship_images.size()]
    movement_speed = randf() * 300
    timer.start()

func get_all_starbases():
    if not all_starbases and get_tree():
        all_starbases = get_tree().get_nodes_in_group("Starbase")
        
    return all_starbases

func _physics_process(delta: float) -> void:
    if current_starbase:        
        if !is_equal_approx(rotation, current_direction):
            rotation = move_toward(rotation, current_direction, delta)

        position += movement_speed * delta * Vector2.RIGHT.rotated(rotation)
        if global_position.distance_to(current_starbase.global_position) < 10:
            current_starbase = null
            current_direction = null
            timer.start()

func _on_Timer_timeout() -> void:
    if not current_starbase:
        current_starbase = self.all_starbases[randi() % self.all_starbases.size()]
        current_direction = (current_starbase.global_position - global_position).angle()
    
