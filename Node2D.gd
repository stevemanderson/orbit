extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	print('test')
	pass # Replace with function body.

func _input_event(_viewport, event, _shape_idx):
	print('again')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
