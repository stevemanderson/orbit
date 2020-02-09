extends '../game_unit.gd'

export var speed = 20

var target
var target_position
var velocity = Vector2()

func set_target(_target):
	target = weakref(_target)
	target_position = target.get_ref().get_global_position()

func _physics_process(_delta):
	if target != null && target.get_ref():
		target_position = target.get_ref().get_global_position()
		
	velocity = (target_position - get_global_position()).normalized() * speed
	look_at(target_position)
	
	var collision_info = move_and_collide(velocity)
	if (collision_info):
		get_tree().root.get_child(0).add_collision(self, collision_info.collider)
	
	if get_global_position().distance_to(target_position) < 20:
		emit_signal('destroyed', self)
