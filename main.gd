extends Node

var entities = {}

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
	entity.connect("destroyed", self, "on_enemy_destroyed")
	add_entity(entity)

func on_enemy_destroyed(entity):
	remove_entity(entity)
	
	var explosion = preload("res://enemies/explosion.tscn").instance()
	explosion.position = entity.position
	
	add_entity(explosion)

func has_entity(entity):
	return entities.has(entity.get_instance_id()) && !entities[entity.get_instance_id()].remove

func get_entity(id):
	if (!entities.has(id) || entities[id].removed):
		return null
	return entities[id]

func add_entity(entity):
	if (!entities.has(entity.get_instance_id())):
		entities[entity.get_instance_id()] = { "entity": entity, "remove": false }
	add_child(entities[entity.get_instance_id()].entity)
	return entities[entity.get_instance_id()]
	
func remove_entity(entity):
	if (entities.has(entity.get_instance_id())):
		entities[entity.get_instance_id()].remove = true
	entity.pause_mode = Node.PAUSE_MODE_STOP
	entity.visible = false

func _on_cleanup_timer_timeout():
	var count = 0
	for key in entities.keys():
		if entities[key].remove:
			entities[key].entity.queue_free()
			entities.erase(key)
			count = count + 1
	print("Cleaned up "+String(count)+" entries")
