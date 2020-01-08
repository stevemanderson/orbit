extends KinematicBody2D

signal planet_selected
signal destroyed

func _ready():
	$AnimationPlayer.play('rotate')

func _input_event(viewport, event, shape_idx):
	emit_signal("planet_selected", self)