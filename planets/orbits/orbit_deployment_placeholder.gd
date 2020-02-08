extends Area2D

func _on_orbit_deployment_placeholder_body_entered(body):
	$CollisionShape2D.set_deferred("disabled", true)
	body.emit_signal("arrived", body)
