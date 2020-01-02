extends Path2D

export var speed = 0

func _ready():
	set_process(true)
	
func _process(delta):
	$follow.set_offset($follow.get_offset() + speed + delta)