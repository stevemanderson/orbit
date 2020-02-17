extends Node2D

signal selected

var selection_entity

func _on_button_selected(button):
	for child in get_children():
		if child != button:
			child.deselect()
	selection_entity = button.selection_entity
	emit_signal('selected', selection_entity)

func _on_button_deselected(_button):
	selection_entity = null

func clear_selection():
	for child in get_children():
		child.deselect()
