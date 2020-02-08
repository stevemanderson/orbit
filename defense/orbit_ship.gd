extends '../game_unit.gd'

export var speed = 2

signal destroyed
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
	if(status == MOVING_TO_ORBIT):
		velocity = (target.position - position).normalized() * speed
		rotation = velocity.angle()
		move_and_collide(velocity)

func _exit_tree():
	emit_signal("destroyed", self)

func get_status():
	return status

func set_status(_status):
	status = _status

func set_target(_target):
	target = _target

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