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
			orbital_entities[i] = preload("res://planets/orbits/orbit_placeholder.tscn").instance()
			placeholders[i] = orbital_entities[i]
			placeholders[i].connect("placeholder_selected", self, "_placeholder_selected")
			$orbit_path.get_child(i).add_child(orbital_entities[i])
			current_offset += offset_per
	$orbit_path.set_process(true)
	
func _process(delta):
	for follow in $orbit_path.get_children():
		follow.set_offset(follow.get_offset() + 0.75 + delta)

func _placeholder_selected(placeholder):
	print('test')