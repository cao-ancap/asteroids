extends TouchScreenButton

# Based on: Gonkee's joystick script for Godot 3 - full tutorial https://youtu.be/uGyEP2LUFPg

export var threshold := 10.0

const radius := Vector2(32, 32)
const boundary := 48.0
const return_accel := 20.0

var ongoing_drag := -1


func _process(delta: float):
	if ongoing_drag == -1:
		position += (-radius - position) * return_accel * delta


func get_button_pos() -> Vector2:
	return position + radius


func _input(event: InputEvent):
	var is_touch_event := event is InputEventScreenTouch
	var is_drag_event := event is InputEventScreenDrag
	if not (is_touch_event or is_drag_event):
		return
	var is_pressed := event.is_pressed()
	if is_drag_event or (is_touch_event and is_pressed):
		var event_dist_from_centre: float = (event.position - get_parent().global_position).length()

		if (
			event_dist_from_centre <= shape.radius * global_scale.x
			or event.get_index() == ongoing_drag
		):
			set_global_position(event.position - radius * global_scale)

			var button_pos := get_button_pos()
			if button_pos.length() > boundary:
				set_position(button_pos.normalized() * boundary - radius)

			ongoing_drag = event.get_index()

		return

	if is_touch_event and not is_pressed and event.get_index() == ongoing_drag:
		ongoing_drag = -1
