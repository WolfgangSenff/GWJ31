extends Button

var character setget set_character

func set_character(value) -> void:
	character = value
	text = character.CharacterName
