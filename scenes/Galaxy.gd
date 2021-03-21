extends Node2D

const CharacterSelectScene = preload("res://scenes/gui/CharacterSelectButton.tscn")
const CharacterSelectButtonGroup = preload("res://resources/CharacterSelectButtonGroup.tres")
onready var engaged_obstacle = $IndividualObstacles/WASP
onready var player

func _ready() -> void:
	player = load(Globals.selectedShip).instance()
	$PlayerHolder.add_child(player)
	player.set_camera($Camera2D)
	Globals.connect("game_over", self, "death_screen")
	Music.play_random_song()
	#Music.set_volume(20) - sets sound very high, can make a control for this to set the value
	#This only works for music
	player.connect("ship_repaired", self, "on_ship_repaired")
	$GUI/MarginContainer/Control/ProgressBar.max_value = player.integrity
	$GUI/MarginContainer/Control/ProgressBar.value = player.integrity
	var char_container = $GUI/MarginContainer/Control/CharacterContainer
	var characters = player.get_node("Characters")
	load_characters(characters)
	for character in characters.get_children():
		character.get_node("Navigator2D").navigation = player.get_node("CharacterNavigation")
		var char_select_button = CharacterSelectScene.instance()
		char_container.add_child(char_select_button)
		char_select_button.character = character    
		char_select_button.connect("toggled", self, "_on_char_selected", [char_select_button])
		char_select_button.group = CharacterSelectButtonGroup
		
	for room in player.get_node("Rooms").get_children():
		room.connect("hit", self, "update_life")
		
func load_characters(characters: Node2D) -> void:
	var Snazzy = load("res://scenes/characters/Character.tscn").instance()
	Snazzy.CharacterName = "Snazzy"
	Snazzy.position = player.get_node("Rooms").get_node("HelmRoom").position
	characters.add_child(Snazzy)
	
	var Zad = load("res://scenes/characters/Character.tscn").instance()
	Zad.CharacterName = "Zad"
	Zad.position = player.get_node("Rooms").get_node("EngineRoom").position
	characters.add_child(Zad)

    
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$GUI/PauseMenu.visible = true
		get_tree().paused = true

func _on_char_selected(is_pressed : bool, button) -> void:
	button.character._character_selected = is_pressed
	
	var chars = get_tree().get_nodes_in_group("Character")
	for character in chars:
		if button.character != character:
			character._character_selected = false
			
	if is_pressed:
		get_tree().call_group("Room", "disable_actions")
	else:
		get_tree().call_group("Room", "enable_actions")

func enter_battle() -> void:
	pass

func update_life(new_life):
	player.integrity = new_life
	$GUI/MarginContainer/Control/ProgressBar.value = new_life

func on_ship_repaired():
    $GUI/MarginContainer/Control/ProgressBar.value = player.integrity
    
func death_screen():
    $GUI/DeathMenu.visible = true

func _on_ZoomButton_pressed() -> void:
    Globals.CameraZoomOut(10)

func death_screen():
	$GUI/DeathMenu.visible = true
