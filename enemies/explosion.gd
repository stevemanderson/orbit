extends Node2D

func _ready():
	$particles.one_shot = true
	$kill_timer.start()

func _on_kill_timer_timeout():
	queue_free()