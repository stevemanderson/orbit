extends KinematicBody2D

signal destroyed

func _exit_tree():
	emit_signal("destroyed", self)