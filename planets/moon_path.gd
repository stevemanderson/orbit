extends Path2D

func _ready():
	set_process(true)
	
func _process(delta):
	$follow.set_offset($follow.get_offset() + 0.75 + delta)


