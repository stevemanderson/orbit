extends Node

var entities = {}

func _ready():
	randomize()

func _on_spawn_timer_timeout():
	var entity = preload("res://enemies/fighter.tscn").instance()
	$spawn_path/spawn_location.set_offset(randi())
	entity.position = $spawn_path/spawn_location.position
	entity.target = $earth
	entity.connect("killed", self, "on_killed")
	entities[entity.get_instance_id()] = entity
	add_child(entity)

func on_killed(type, instance_id, collider_instance_id, position):
	clearEntity(instance_id)
	clearEntity(collider_instance_id)
	
func clearEntity(id):
	if (!entities.has(id)):
		return

	var instance = entities[id]
	var position = instance.position

	entities.erase(id)
	instance.queue_free()

	var explosion = preload("res://enemies/fighter_death.tscn").instance()
	explosion.position = position
	add_child(explosion)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var entity = preload("res://ammo/missile.tscn").instance()
			entity.position = $launch_point.position
			entity.target = event.position
			entity.connect("killed", self, "on_killed")
			add_child(entity)
			entities[entity.get_instance_id()] = entity