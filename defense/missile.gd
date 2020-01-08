extends KinematicBody2D

export var speed = 20

var target
var target_position
var velocity = Vector2()
var is_destroyed = false
var Explosion = preload("res://enemies/explosion.tscn")

func initialize(entity, pos):
	target_position = entity.position
	target = weakref(entity)
	position = pos

func _process(delta):
	if target == null || !target.get_ref():
		return
	target_position = target.get_ref().position

func _physics_process(delta):
	velocity = (target_position - position).normalized() * speed
	rotation = velocity.angle()
	var result = move_and_collide(velocity)
	
	if position.distance_to(target_position) < 20:
		queue_free()
	
func _exit_tree():
	var main = get_tree().root.get_child(0)
	var explosion = Explosion.instance()
	explosion.position = position
	main.add_child(explosion)
