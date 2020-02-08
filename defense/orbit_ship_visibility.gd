extends Area2D

var Missile = preload("res://defense/missile.tscn")

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

		call_deferred('add_missile', next, get_parent().get_parent())

		break;

func add_missile(next, container):
	var missile = Missile.instance()
	missile.initialize(next.get_ref(), container.global_position)
	get_tree().root.get_child(0).get_child(0).add_child(missile)
	targets.push_front(next)