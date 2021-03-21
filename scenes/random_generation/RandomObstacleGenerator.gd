extends Node2D

export (int) var TotalObstacles
export (Vector2) var MinSizeBetweenObstacles
export (Vector2) var MaxSizeBetweenObstacles

var all_obstacle_resources = [
    preload("res://obstacle_resources/PlanetObstacle.tres"),
    preload("res://obstacle_resources/StarbaseObstacle.tres")
   ]

var all_obstacle_probabilities = [
    .1,
    .01
   ]

var all_obstacle_sizes = [
    128,
    80
   ]

const RandomRoomScene = preload("res://scenes/random_generation/ObstacleRoom.tscn")

func _ready() -> void:
    generate()

func generate():
    var total_obstacle_percentage = 0
    for obst in all_obstacle_probabilities:
        total_obstacle_percentage += obst
    var current_obstacle_index = 0    
    for obst in TotalObstacles:
        var room = RandomRoomScene.instance()
        room.set_room_size(80 + randi() % 128)
        add_child(room)
        current_obstacle_index += 1
        
#        var current_percentage_total = 0
#        var rand_chance = randf()
#        for obstacle_resource in all_obstacle_resources.keys():
#            current_percentage_total += all_obstacle_resources[obstacle_resource]
#            if current_percentage_total < rand_chance:
#                var random_room = RandomRoomScene.instance()
#                random_room.ObstacleRes = obstacle_resource
#                add_child(random_room)
    
    yield(get_tree().create_timer(1.2), "timeout")
    for child in get_children():
        var random_percent = rand_range(0, total_obstacle_percentage)
        var obst_index = 0
        var current_obstacle_chance = 0
        for obst_chance in all_obstacle_probabilities:
            current_obstacle_chance += obst_chance
            if current_obstacle_chance > random_percent:
                break
            obst_index += 1
        child.place_obstacle_in_galaxy(all_obstacle_resources[obst_index])
