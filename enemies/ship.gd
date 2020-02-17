extends '../game_unit.gd'

var Missile = preload("res://defense/missile.tscn")
var Explosion = preload("res://enemies/explosion.tscn")

export var speed = 0

var target
var velocity = Vector2()
var MOVING = 0
var ATTACKING = 1
var state = MOVING
var enemies = []

func _physics_process(_delta):
	if (!target && !target.get_ref()):
		return

	if state == MOVING:
		var tar = target.get_ref()
		velocity = (tar.position - position).normalized() * speed
		rotation = velocity.angle()
	elif state == ATTACKING:
		velocity = Vector2()
		if enemies.size() > 0:
			look_at(enemies[0].global_position)
	
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

func _on_attack_range_body_entered(body):
	enemies.push_back(body)
	state = ATTACKING
	if $attack_timer.is_stopped():
		call_deferred('attack', enemies[0])

func _on_attack_range_body_exited(body):
	enemies.erase(body)
	if enemies.size() > 0:
		if $attack_timer.is_stopped():
			attack(enemies[0])	
			$attack_timer.start()
	else:
		$attack_timer.stop()
		state = MOVING

func _on_attack_timer_timeout():
	if enemies.size() > 0:
		attack(enemies[0])

func attack(enemy):
	$attack_timer.start()
	var missile = Missile.instance()
	missile.set_collision_layer_bit(2, false)
	missile.set_collision_layer_bit(7, true)
	missile.set_collision_mask_bit(1, true)
	missile.set_target(enemy)
	get_parent().add_child(missile)
	missile.set_global_position(get_global_position())
	missile.connect('destroyed', self, 'on_missile_destroyed')

func on_missile_destroyed(missile):
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.position = missile.position
	missile.queue_free()
