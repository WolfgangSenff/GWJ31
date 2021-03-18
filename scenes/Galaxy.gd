extends Node2D

const CharacterSelectScene = preload("res://scenes/gui/CharacterSelectButton.tscn")
const CharacterSelectButtonGroup = preload("res://resources/CharacterSelectButtonGroup.tres")
onready var engaged_obstacle = $IndividualObstacles/WASP
onready var player = $PlayerHolder/WASP

func _ready() -> void:
    player.set_camera($Camera2D)
    
    var char_container = $GUI/MarginContainer/Control/CharacterContainer
    var characters = $PlayerHolder/WASP/Characters

    for character in characters.get_children():
        var char_select_button = CharacterSelectScene.instance()
        char_container.add_child(char_select_button)
        char_select_button.character = character    
        char_select_button.connect("toggled", self, "_on_char_selected", [char_select_button])
        char_select_button.group = CharacterSelectButtonGroup

func _on_char_selected(is_pressed : bool, button) -> void:
    button.character._character_selected = is_pressed
    
    var chars = get_tree().get_nodes_in_group("Character")
    for character in chars:
        if button.character != character:
            character._character_selected = false
            
    get_tree().call_group("Room", "disable_actions")
    

func enter_battle() -> void:
    pass
