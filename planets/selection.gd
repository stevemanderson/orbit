extends Area2D

var is_selected = false

func _ready():
	set_process(true)
	$sprite.hide()
	get_tree().root.get_child(0).selection_manager.connect('selected', self, 'on_entity_selected')
	get_tree().root.get_child(0).selection_manager.connect('deselected', self, 'on_entity_deselected')

func on_entity_selected(entity):
	if entity == get_parent().get_parent():
		$sprite.show()
		is_selected = true

func on_entity_deselected(entity):
	if entity == get_parent().get_parent():
		$sprite.hide()
		is_selected = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			is_selected = !is_selected
			if is_selected:
				get_tree().root.get_child(0).selection_manager.select(get_parent().get_parent())
				$sprite.show()
			else:
				get_tree().root.get_child(0).selection_manager.deselect(get_parent().get_parent())
				$sprite.hide()
