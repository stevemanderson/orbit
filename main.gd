extends Node

var entities = {}

export var world_size = Vector2(3000, 3000)

func _ready():
	randomize()

func _on_spawn_timer_timeout():
	var type = randi() % 2
	var entity = null
	
	if (type == 0):
		entity = preload("res://enemies/fighter.tscn").instance()
	elif(type == 1):
		entity = preload("res://enemies/cruiser.tscn").instance()

	$spawn_path/spawn_location.set_offset(randi())
	entity.position = $spawn_path/spawn_location.position + $spawn_path.position
	entity.target = $earth
	entity.connect("killed", self, "on_killed")
	entities[entity.get_instance_id()] = entity
	add_child(entity)

func on_killed(type, instance_id, collider_instance_id, position):
	clearEntity(instance_id)
	clearEntity(collider_instance_id)

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			var entity = preload("res://ammo/missile.tscn").instance()
#			entity.position = $launch_point.position
#			entity.target = $camera.get_global_mouse_position()
#			add_child(entity)
#			entities[entity.get_instance_id()] = entity

func clearEntity(id):
	if (!entities.has(id)):
		return

	var instance = entities[id]
	var position = instance.position

	entities.erase(id)
	instance.queue_free()

	var explosion = preload("res://enemies/explosion.tscn").instance()
	explosion.position = position
	add_child(explosion)