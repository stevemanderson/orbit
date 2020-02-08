extends '../game_unit.gd'

export var speed = 0

var target
var velocity = Vector2()
var Explosion = preload("res://enemies/explosion.tscn")

func _physics_process(_delta):
	if (!target && !target.get_ref()):
		return

	var tar = target.get_ref()
	velocity = (tar.position - position).normalized() * speed
	rotation = velocity.angle()
	
	var collision_info = move_and_collide(velocity)
	if (collision_info):
		get_tree().root.get_child(0).add_collision(self, collision_info.collider)

func _exit_tree():
	call_deferred('explode')	

func explode():
	var explosion = Explosion.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)

func set_target(_target):
	target = weakref(_target)
