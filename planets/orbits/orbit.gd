extends Node2D

export (Array, PackedScene) var orbital_entities

func _ready():
	var offset_per = $orbit_path.curve.get_baked_length() / orbital_entities.size()
	var current_offset = offset_per
	for i in range(orbital_entities.size()):
		$orbit_path.get_child(i).set_offset(current_offset)
		if orbital_entities[i] != null:
			$orbit_path.get_child(i).add_child(orbital_entities[i].instance())
		current_offset += offset_per
	$orbit_path.set_process(true)
	
func _process(delta):
	for follow in $orbit_path.get_children():
		follow.set_offset(follow.get_offset() + 0.75 + delta)