extends Node

export (int) var player

onready var selection_manager = get_tree().root.get_child(0).selection_manager

func _ready():
	$ship_selection.hide()
	selection_manager.connect('selected', self, 'on_selected')
	selection_manager.connect('deselected', self, 'on_deselected')
	
func on_selected(entity):
	if entity == self:
		selection_manager.deselect_all()
		$ship_selection.clear_selection()
		$ship_selection.show()

func on_deselected(entity):
	if entity == self:
		$ship_selection.clear_selection()
		$ship_selection.hide()

func _on_ship_selection_selected(ship_entity):
	$ship_selection.hide()
	for child in get_children():
		if child.is_in_group('orbit'):
			child.selected_ship = ship_entity

func _on_orbit_location_selected():
	selection_manager.deselect(self)
