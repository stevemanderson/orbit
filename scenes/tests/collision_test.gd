extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$fighter.set_target($other)
	$fighter2.set_target($other)
	$fighter3.set_target($other)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
