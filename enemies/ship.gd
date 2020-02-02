extends '../game_unit.gd'

export var speed = 0

var target
var velocity = Vector2()
var collided = false
var Explosion = preload("res://enemies/explosion.tscn")

func _physics_process(delta):
	velocity = (target.position - position).normalized() * speed
	rotation = velocity.angle()
	
	var collision_info = move_and_collide(velocity)
	if (collision_info):
		var collider = collision_info.collider
		
		# Don't do anything if it's firepower
		# It will be handled in the weapon.
		# Most likely need to handle this far differently later
		if collider.is_in_group('firepower'):
			return
		
		var temp_velocity = velocity
		collided = true		
		collider.take_damage(self)
		take_damage(collider)
		velocity = temp_velocity

func _exit_tree():
	var explosion = Explosion.instance()
	explosion.position = global_position
	get_tree().root.get_child(0).add_child(explosion)
