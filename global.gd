extends Node

const SelectionManager = preload("selection_manager.gd")

onready var selection_manager = SelectionManager.new()

var collisions = {}
export (int) var current_player

func add_collision(object1, object2):
	if (collisions.has(str(object1.get_instance_id(), "_", object2.get_instance_id())) ||
		collisions.has(str(object2.get_instance_id(), "_", object1.get_instance_id()))):
		return

	collisions[str(object1.get_instance_id(), "_", object2.get_instance_id())] = {
		"object1": object1,
		"object2": object2,
		"created": OS.get_ticks_msec(),
		"lifetime": 2000
	}

	if ((object2.is_in_group("weapons")) ||
		(object1.is_in_group("weapons"))):
		object1.take_damage(object2)
		object2.take_damage(object1)
	elif ((object1.is_in_group("enemies") && object2.is_in_group("ally")) ||
		(object2.is_in_group("enemies") && object1.is_in_group("ally"))):
		object1.take_damage(object2)
		object2.take_damage(object1)

func clear_collisions():
	for key in collisions.keys():
		if (OS.get_ticks_msec() > collisions[key]["created"] + collisions[key]['lifetime']):
			collisions.erase(key)

func _process(_delta):
	clear_collisions()

func get_current_player():
	return current_player
