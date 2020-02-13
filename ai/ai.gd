extends Node

var entities = {}
var Fighter = preload("res://enemies/fighter.tscn")
var Cruiser = preload("res://enemies/cruiser.tscn")

func _ready():
	randomize()
	$spawn_timer.start()

func _on_spawn_timer_timeout():
	var type = randi() % 2
	var entity = null
	
	if (type == 0):
		entity = Fighter.instance()
	elif(type == 1):
		entity = Cruiser.instance()

	entity.global_position = $planet.global_position
	entity.set_target(get_parent().find_node("earth"))

	add_child(entity)
