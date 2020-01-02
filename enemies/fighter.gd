extends KinematicBody2D

export (PackedScene) var target
export var speed = 0

signal killed

var velocity = Vector2()

func _physics_process(delta):
	velocity = (target.position - position).normalized() * speed
	rotation = velocity.angle()
	var collision_info = move_and_collide(velocity)
	if (collision_info):
		emit_signal("killed", "missile", get_instance_id(), collision_info.collider.get_instance_id(), position)