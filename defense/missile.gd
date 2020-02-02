extends '../game_unit.gd'

export var speed = 20

var target
var target_position
var velocity = Vector2()
var is_destroyed = false
var collided = false
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
	
	var collision_info = move_and_collide(velocity)
	if (collision_info):
		collided = true
		var collider = collision_info.collider
		collider.take_damage(self)
		take_damage(collider)
	
	if position.distance_to(target_position) < 20:
		queue_free()
	
func _exit_tree():
	var explosion = Explosion.instance()
	explosion.position = position
	get_tree().root.get_child(0).add_child(explosion)