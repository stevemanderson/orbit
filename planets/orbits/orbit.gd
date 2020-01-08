extends Node2D

export var orbital_speed = 0.75
export var orbital_entity_count = 0
export var orbital_radius = 2

var orbital_entities = {}
var placeholders = {}

var OrbitPlaceholder = preload("res://planets/orbits/orbit_placeholder.tscn")
var OrbitalShip = preload("res://defense/orbit_ship.tscn")

func _ready():
	if orbital_entity_count > 0:
		var offset_per = $orbit_path.curve.get_baked_length() / orbital_entity_count
		var current_offset = offset_per
		for i in range(orbital_entity_count):
			$orbit_path.get_child(i).set_offset(current_offset)
			var entity = OrbitPlaceholder.instance()
			orbital_entities[entity.get_instance_id()] = {}
			orbital_entities[entity.get_instance_id()].index = i
			orbital_entities[entity.get_instance_id()].entity = entity
			placeholders[i] = orbital_entities[entity.get_instance_id()].entity
			placeholders[i].connect("placeholder_selected", self, "on_placeholder_selected")
			$orbit_path.get_child(i).add_child(orbital_entities[entity.get_instance_id()].entity)
			current_offset += offset_per
	$orbit_path.set_process(true)
	
func _process(delta):
	for follow in $orbit_path.get_children():
		follow.set_offset(follow.get_offset() + orbital_speed + delta)

func on_placeholder_selected(placeholder):
	var key = placeholder.get_instance_id()
	if orbital_entities.has(key):
		var index = orbital_entities[key].index
		var entity = orbital_entities[key].entity
		
		var child = $orbit_path.get_child(index)
		child.remove_child(entity)
		
		orbital_entities.erase(key)
		
		var ship = OrbitalShip.instance()
		var ship_key = ship.get_instance_id()
		orbital_entities[ship_key] = {}
		orbital_entities[ship_key].index = index
		orbital_entities[ship_key].entity = ship
		orbital_entities[ship_key].entity.connect("destroyed", self, "on_orbital_entity_destroyed")
		child.add_child(orbital_entities[ship_key].entity)

func on_orbital_entity_destroyed(entity):
	var key = entity.get_instance_id()
	if orbital_entities.has(key):
		print(key)
		var index = orbital_entities[key].index
		var child = $orbit_path.get_child(index)
		orbital_entities.erase(key)
		
		var placeholder = placeholders[index]
		var placeholder_key = placeholder.get_instance_id()
		orbital_entities[placeholder_key] = {}
		orbital_entities[placeholder_key].index = index
		orbital_entities[placeholder_key].entity = placeholder
		child.add_child(placeholder)
