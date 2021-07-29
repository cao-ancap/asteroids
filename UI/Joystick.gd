extends Node2D

export var threshold := 5
export var sensitivity := 100.0


func _ready():
	$JoyButton.threshold = threshold


func get_direction() -> Vector2:
	var button_pos: Vector2 = $JoyButton.get_button_pos()
	return (
		button_pos.normalized() * sensitivity / 100.0
		if button_pos.length() > $JoyButton.threshold
		else Vector2.ZERO
	)
