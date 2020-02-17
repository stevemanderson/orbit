extends '../game_unit.gd'

var Explosion = preload("res://enemies/explosion.tscn")

export var speed = 2

signal deployed
signal arrived

var MOVING_TO_ORBIT = 0
var IN_ORBIT = 1

var velocity = Vector2()
var status = MOVING_TO_ORBIT
var target
var orbit_index
var orbit_placeholder

func _physics_process(_delta):
	if (!target || !target.get_ref()):
		return
		

	if(status == MOVING_TO_ORBIT):
		velocity = (target.get_ref().position - position).normalized() * speed
		rotation = velocity.angle()

	var collision_info = move_and_collide(velocity)

	if (status == IN_ORBIT && collision_info):
		get_tree().root.get_child(0).add_collision(self, collision_info.collider)

func get_status():
	return status

func set_status(_status):
	status = _status

func set_target(_target):
	target = weakref(_target)

func set_orbit_index(_orbit_index):
	orbit_index = _orbit_index

func get_orbit_index():
	return orbit_index

func set_orbit_placeholder(_orbit_placeholder):
	orbit_placeholder = _orbit_placeholder

func get_orbit_placeholder():
	return orbit_placeholder

func get_orbit_key():
	if(status == IN_ORBIT):
		return get_instance_id()
	else:
		return orbit_placeholder.get_instance_id()
