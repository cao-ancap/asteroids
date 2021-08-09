extends Node2D

export var threshold := 5
export var sensitivity := 100.0

onready var ndJoyButton := $JoyButton


func get_direction() -> Vector2:
	var button_pos: Vector2 = ndJoyButton.get_button_pos()
	return (
		button_pos.normalized() * sensitivity / 100.0
		if button_pos.length() > threshold
		else Vector2.ZERO
	)
