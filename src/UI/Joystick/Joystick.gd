class_name Joystick
extends Node2D

export var threshold := 5
export var sensitivity := 100.0

onready var ndJoyButton := $JoyButton


func _ready():
	control_joybutton_visibility()


func get_direction() -> Vector2:
	var button_pos: Vector2 = ndJoyButton.get_button_pos()
	return (
		button_pos.normalized() * sensitivity / 100.0
		if button_pos.length() > threshold
		else Vector2.ZERO
	)


func _on_Joystick_visibility_changed():
	control_joybutton_visibility()


func control_joybutton_visibility():
	if is_visible_in_tree():
		ndJoyButton.show()
		ndJoyButton.set_process_input(true)
	else:
		ndJoyButton.hide()
		ndJoyButton.set_process_input(false)
