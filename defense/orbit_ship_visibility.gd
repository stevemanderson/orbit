extends RigidBody2D

var target

func _on_orbit_ship_visibility_body_entered(body):
	target = body
	target.connect("destroyed", self, "_on_target_destroyed")
	launch()
	$timeout.start()

func _on_timeout_timeout():
	launch()
	
func launch():
	var missile = preload("res://defense/missile.tscn").instance()
	missile.initialize(target, global_position)
	get_tree().root.get_child(0).add_entity(missile)
	
func _on_target_destroyed(entity):
	target = null
	$timeout.stop()