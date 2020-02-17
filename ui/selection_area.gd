extends Area2D

signal selected

onready var is_selected = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			is_selected = !is_selected
			emit_signal('selected', is_selected)
