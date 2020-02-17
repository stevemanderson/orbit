extends Area2D

signal placeholder_selected

func _ready():
	set_process(true)
	$orbit_placeholder.hide()
	get_tree().root.get_child(0).selection_manager.connect('selected', self, 'on_selection')
	get_tree().root.get_child(0).selection_manager.connect('deselected', self, 'on_deselection')

func on_selection(_entity):
	$orbit_placeholder.show()

func on_deselection(_entity):
	$orbit_placeholder.hide()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("placeholder_selected", self)
