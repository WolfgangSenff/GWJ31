extends Node

onready var all_planet_textures = preload("res://resources/PlanetTextureFolderResource.tres")

func _ready() -> void:
    randomize()       
    
