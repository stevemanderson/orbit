extends ColorRect

signal wave_complete

export var seconds = 0
var progress_step

func _ready():
	progress_step = rect_size.y / (seconds / $progress_timer.wait_time)

func _on_progress_timer_timeout():
	var new_size = Vector2($progress.rect_size.x, $progress.rect_size.y)
	new_size.y = new_size.y + progress_step
	$progress.rect_size = new_size
	$progress.rect_position.y -= progress_step
	
	if rect_size.y <= $progress.rect_size.y:
		$progress_timer.stop()