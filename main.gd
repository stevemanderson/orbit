extends Node

var entities = {}
var Explosion = preload("res://enemies/explosion.tscn")
var Fighter = preload("res://enemies/fighter.tscn")
var Cruiser = preload("res://enemies/cruiser.tscn")

func _ready():
	randomize()

func _on_spawn_timer_timeout():
	var type = randi() % 2
	var entity = null
	
	if (type == 0):
		entity = Fighter.instance()
	elif(type == 1):
		entity = Cruiser.instance()

	$spawn_path/spawn_location.set_offset(randi())
	entity.position = $spawn_path/spawn_location.position + $spawn_path.position
	entity.target = $earth
	entity.connect("destroyed", self, "on_enemy_destroyed")
	
	add_child(entity)

func on_enemy_destroyed(entity):
	entity.queue_free()
	var explosion = Explosion.instance()
	explosion.position = entity.position
	add_child(explosion)