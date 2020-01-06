extends KinematicBody2D

export (PackedScene) var target
export var speed = 0

signal destroyed

var velocity = Vector2()
var collided = false

func _physics_process(delta):
	velocity = (target.position - position).normalized() * speed
	rotation = velocity.angle()
	
	if !collided:
		var collision_info = move_and_collide(velocity)
		if (collision_info):
			if collision_info.collider.collision_mask != 32:
				collided = true
				emit_signal("destroyed", self)