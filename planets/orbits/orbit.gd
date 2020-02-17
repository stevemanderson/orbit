extends Node2D

export var orbital_speed = 0.75
export var orbital_entity_count = 0
export var orbital_radius = 2

var orbital_entities = {}
var placeholders = {}

var OrbitPlaceholder = preload("res://planets/orbits/orbit_placeholder.tscn")
var OrbitalShip = preload("res://defense/orbit_ship.tscn")
var OrbitDeploymentPlaceholder = preload("res://planets/orbits/orbit_deployment_placeholder.tscn")

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
	if get_orbiting_planet().player != get_tree().root.get_child(0).get_current_player():
		return
	if !get_tree().root.get_child(0).selection_manager.is_selected(get_orbiting_planet()):
		return

	var key = placeholder.get_instance_id()
	if orbital_entities.has(key):
		var index = orbital_entities[key].index
		var entity = orbital_entities[key].entity
		
		var child = $orbit_path.get_child(index)
		child.remove_child(entity)
		
		orbital_entities.erase(key)

		# deployed placeholder
		var deployed = OrbitDeploymentPlaceholder.instance()
		var placeholder_key = deployed.get_instance_id()
		
		orbital_entities[placeholder_key] = {}
		orbital_entities[placeholder_key].index = index
		orbital_entities[placeholder_key].entity = deployed
		child.add_child(orbital_entities[placeholder_key].entity)

		# deploy the ship
		var ship = OrbitalShip.instance()
		ship.connect("destroyed", self, "on_orbital_entity_destroyed")
		ship.connect("arrived", self, "on_deployment_arrived")
		ship.set_target(child);
		ship.set_orbit_index(index)
		ship.set_orbit_placeholder(deployed)
		get_parent().add_child(ship)

func on_deployment_arrived(ship):
	if (ship.get_status() == ship.IN_ORBIT):
		return
	call_deferred('handle', ship)

func on_orbital_entity_destroyed(entity):
	remove_orbital_entity(entity.get_orbit_key())

func remove_orbital_entity(key, add_placeholder=true):
	if orbital_entities.has(key):
		var index = orbital_entities[key].index
		var child = $orbit_path.get_child(index)
		orbital_entities.erase(key)
		child.remove_child(child.get_child(0))

		if(add_placeholder):
			var placeholder = placeholders[index]
			var placeholder_key = placeholder.get_instance_id()
			orbital_entities[placeholder_key] = {}
			orbital_entities[placeholder_key].index = index
			orbital_entities[placeholder_key].entity = placeholder
			child.add_child(placeholder)

		return true
	else:
		return false

func handle(ship):
	remove_orbital_entity(ship.get_orbit_key(), false)

	ship.position = Vector2(0, 0)
	ship.set_status(ship.IN_ORBIT)
	ship.set_target(null)
	ship.set_orbit_placeholder(null)

	var child = $orbit_path.get_child(ship.get_orbit_index())
	get_parent().remove_child(ship)
	child.add_child(ship)
	ship.set_owner(child)

	var ship_key = ship.get_instance_id()
	orbital_entities[ship_key] = {}
	orbital_entities[ship_key].index = ship.get_orbit_index()
	orbital_entities[ship_key].entity = ship

func get_orbiting_planet():
	return get_parent()
