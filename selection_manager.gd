extends Node

signal selected
signal deselected

var entities = []

func select(entity):
	emit_signal('selected', entity)
	entities.push_back(entity)

func deselect(entity):
	emit_signal('deselected', entity)
	entities.erase(entity)

func deselect_all():
	while entities.size() > 0:
		var entity = entities.pop_front()
		emit_signal('deselected', entity)

func is_selected(entity):
	return entities.has(entity)