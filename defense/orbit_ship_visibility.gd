extends Area2D

var Missile = preload("res://defense/missile.tscn")
var Explosion = preload("res://enemies/explosion.tscn")

var targets = []
var shot_taken = false

func _on_orbit_ship_visibility_body_entered(body):
	targets.push_front(weakref(body))
	launch()
	

func _on_timeout_timeout():
	shot_taken = false
	
	var temp = []
	while(targets.size() > 0):
		var next = targets.pop_front()
		if next != null && next.get_ref():
			temp.push_back(next)
	targets = temp
	
	if targets.size() == 0:
		return

	launch()

func launch():
	if shot_taken:
		return

	while(targets.size() > 0):
		var next = targets.pop_front()
		if next == null || !next.get_ref():
			continue
		shot_taken = true
		$timeout.start()
		call_deferred('add_missile', next)
		break;

func add_missile(next):
	var missile = Missile.instance()
	missile.set_target(next.get_ref())
	get_parent().add_child(missile)
	missile.set_global_position(get_global_position())
	targets.push_front(next)
	missile.connect('destroyed', self, 'on_missile_destroyed')

func on_missile_destroyed(missile):
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.position = missile.position
	missile.queue_free()
