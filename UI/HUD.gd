extends Control


func _ready():
	update_joystick()
	update_joystick_sensitivity()


func update_score(score: int):
	$ScoreLabel.text = str(score)


func set_hp_value(hp: int):
	$HPBar.value = hp

func update_joystick():
	if Global.has_joystick:
		$Joystick.show()
	else:
		$Joystick.hide()

func update_joystick_sensitivity():
	$Joystick.sensitivity = Global.joystick_sensitivity

