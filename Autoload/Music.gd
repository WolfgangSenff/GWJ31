extends Node

onready var _current_player = $Intro
onready var _random_songs = $RandomSongs
var random_song_players

func _ready() -> void:
    randomize()
    random_song_players = _random_songs.get_children()

func play_random_song() -> void:
    _current_player.stop()
    _current_player = random_song_players[randi() % _random_songs.get_child_count()]
    _current_player.play(0.0)

func set_volume(value : float) -> void:
    for player in random_song_players:
        player.volume_db = value
