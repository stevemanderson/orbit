extends Camera2D

export var scroll_speed = 5
export var scroll_area_percent = 5

export var min_zoom = 1
export var max_zoom = 3.3

var left_down = false
var left_down_position = 0
var is_within_scrolling = false
var scroll_direction_x = 0
var scroll_direction_y = 0

func _physics_process(delta):
	position.x += scroll_direction_x
	position.y += scroll_direction_y
	

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_WHEEL_UP:
			zoom.x -= 0.1
			zoom.y -= 0.1
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoom.x += 0.1
			zoom.y += 0.1
		elif event.button_index == BUTTON_LEFT:
			left_down = true
			left_down_position = event.position
		if zoom.x < min_zoom:
			zoom.x = min_zoom
		if zoom.y < min_zoom:
			zoom.y = min_zoom
		if zoom.x > max_zoom:
			zoom.x = max_zoom
		if zoom.y > max_zoom:
			zoom.y = max_zoom
	elif event is InputEventMouseButton and !event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			left_down = false
	elif event is InputEventMouseMotion:
		var rect_size = get_viewport().size
		scroll_direction_x = 0
		scroll_direction_y = 0
		
		if event.position.x > rect_size.x - (rect_size.x * 0.01 * scroll_area_percent):
			scroll_direction_x = scroll_speed * 1 * zoom.x
		elif event.position.x < rect_size.x * 0.01 * scroll_area_percent:
			scroll_direction_x = scroll_speed * -1 * zoom.x
		if event.position.y > rect_size.y - rect_size.y * 0.01 * scroll_area_percent:
			scroll_direction_y = scroll_speed * 1 * zoom.y
		elif event.position.y < rect_size.y * 0.01 * scroll_area_percent:
			scroll_direction_y = scroll_speed * -1 * zoom.y