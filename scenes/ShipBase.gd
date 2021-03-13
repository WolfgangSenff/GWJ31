extends Node2D

# Put data here for the overall ship.
#  Export it mostly and then we can have different values per ship.

# Each of the rooms will signal up to the ShipBase when changes
#  in status have to occur based on the room.

# When an attack happens on the ship, it will occur here and
#  we'll call down to the appropriate room to take the damage
#  however it will happen.
