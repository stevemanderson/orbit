extends KinematicBody2D

export var hit_points = 0
export var current_hit_points = 0

func take_damage(entity):
	current_hit_points = current_hit_points - entity.hit_points
	if current_hit_points <= 0:
		set_process(false)
		queue_free()