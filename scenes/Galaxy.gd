extends Node2D

onready var engaged_obstacle = $IndividualObstacles/WASP
onready var player = $PlayerHolder/WASP

func _ready() -> void:
    player.set_camera($Camera2D)

func enter_battle() -> void:
    pass
