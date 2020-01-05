extends Node2D

export var orbital_entity_count = 0

var orbital_entities = {}
var placeholders = {}

func _ready():
	if orbital_entity_count > 0:
		var offset_per = $orbit_path.curve.get_baked_length() / orbital_entity_count
		var current_offset = offset_per
		for i in range(orbital_entity_count):
			$orbit_path.get_child(i).set_offset(current_offset)
			var entity = preload("res://planets/orbits/orbit_placeholder.tscn").instance()
			orbital_entities[entity.get_instance_id()] = {}
			orbital_entities[entity.get_instance_id()].index = i
			orbital_entities[entity.get_instance_id()].entity = entity
			placeholders[i] = orbital_entities[entity.get_instance_id()].entity
			placeholders[i].connect("placeholder_selected", self, "_placeholder_selected")
			$orbit_path.get_child(i).add_child(orbital_entities[entity.get_instance_id()].entity)
			current_offset += offset_per
	$orbit_path.set_process(true)
	
func _process(delta):
	for follow in $orbit_path.get_children():
		follow.set_offset(follow.get_offset() + 0.75 + delta)

func _placeholder_selected(placeholder):
	var key = placeholder.get_instance_id()
	if orbital_entities.has(key):
		var index = orbital_entities[key].index
		var entity = orbital_entities[key].entity
		
		var child = $orbit_path.get_child(index)
		child.remove_child(entity)
		
		orbital_entities.erase(key)
		
		orbital_entities[key] = {}
		orbital_entities[key].index = index
		orbital_entities[key].entity = preload("res://defense/orbit_ship.tscn").instance()
		child.add_child(orbital_entities[key].entity)
