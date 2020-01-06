extends KinematicBody2D

export var speed = 20

var target_position
var velocity = Vector2()

func initialize(entity, pos):
	target_position = entity.global_position
	position = pos

func _physics_process(delta):
	if target_position == null:
		return
	velocity = (target_position - position).normalized() * speed
	rotation = velocity.angle()
	var result = move_and_collide(velocity)
	
	if velocity.length() < 10:
		_clear()
	
func _clear():
	var main = get_tree().root.get_child(0)
	main.remove_entity(self)
	pause_mode = Node.PAUSE_MODE_STOP
	
	var explosion = preload("res://enemies/explosion.tscn").instance()
	explosion.position = position
	main.add_entity(explosion)
