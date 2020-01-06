extends Node2D

export var orbital_speed = 1

func _process(delta):
	for follow in $orbit_path.get_children():
		follow.set_offset(follow.get_offset() + orbital_speed + delta)