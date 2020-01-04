extends KinematicBody2D

signal killed

export var speed = 20

var target = Vector2()
var velocity = Vector2()

func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	rotation = velocity.angle()
	
	if (target - position).length() > 10:
		var collision_info = move_and_collide(velocity)
		if (collision_info):
			emit_signal("killed", "missile", get_instance_id(), collision_info.collider.get_instance_id(), position)
	else:
		emit_signal("killed", "missile", get_instance_id(), null, position)
		
func get_position():
	return position