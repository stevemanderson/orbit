extends Node2D

signal selected
signal deselected

export (PackedScene) var selection_entity

func _ready():
	set_process(true)
	$focused.hide()

func deselect():
	$focused.hide()
	$selection_area.is_selected = false
	emit_signal('deselected', self)

func select():
	$focused.show()
	$selection_area.is_selected = true
	emit_signal('selected', self)

func _on_selection_area_selected(is_selected):
	if is_selected:
		$focused.show()
		emit_signal('selected', self)
	else:
		$focused.hide()
		emit_signal('deselected', self)
