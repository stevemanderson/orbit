extends Area2D

signal placeholder_selected

func _ready():
	set_process(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("placeholder_selected", self)