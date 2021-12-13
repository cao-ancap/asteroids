extends Control

signal paused

onready var ndScoreLabel := $ScoreLabel
onready var ndHPBar := $HPBar
onready var ndJoystick := $Joystick


func _ready():
	update_joystick()
	update_joystick_sensitivity()
	reconfig_hp_bar()


func reconfig_hp_bar():
	ndHPBar.max_value = Utils.calc_difficulty_to_hp(Config.difficulty)


func update_score(score: int):
	ndScoreLabel.text = str(score)


func set_hp_value(hp: int):
	ndHPBar.value = hp


func update_joystick():
	if Config.has_joystick:
		ndJoystick.show()
	else:
		ndJoystick.hide()


func update_joystick_sensitivity():
	ndJoystick.sensitivity = Config.joystick_sensitivity


func _on_PauseButton_pressed():
	emit_signal("paused")
