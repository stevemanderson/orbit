extends Area2D

signal placeholder_selected

onready var selection_manager = get_tree().root.get_child(0).selection_manager

func _ready():
	set_process(true)
	$orbit_placeholder.hide()
	selection_manager.connect('selected', self, 'on_selection')
	selection_manager.connect('deselected', self, 'on_deselection')

func on_selection(entity):
	if get_parent() && entity == get_system():
		$orbit_placeholder.show()

func on_deselection(entity):
	if get_parent() && entity == get_system():
		$orbit_placeholder.hide()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("placeholder_selected", self)

func get_system():
	return get_parent().get_parent().get_parent().get_parent()
