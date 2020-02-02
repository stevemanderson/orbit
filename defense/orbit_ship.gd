extends '../game_unit.gd'

signal destroyed

func _exit_tree():
	emit_signal("destroyed", self)
