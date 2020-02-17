extends Area2D


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			print('deselect_all')
			get_tree().root.get_child(0).selection_manager.deselect_all()
