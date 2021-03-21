extends Node2D

# Presumably this takes some functionality and points to the ship
# When something happens (say the obstacle is a blackhole and
#  the ship gets too close), the obstacle is responsible for
#  modifying the ship/damaging it/whatever

onready var sprite = $ObstacleUnderlying
