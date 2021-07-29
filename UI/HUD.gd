extends Panel

signal game_started
signal configuration_opened

const start_message := "Dodge the Asteroids"


func _ready():
	$MessageLabel.text = start_message
	$StartButton.grab_focus()
	$Joystick.sensitivity = Global.joystick_sensitivity
	if Global.is_web:
		$ExitButton.hide()
	else:
		$ExitButton.show()


func show_message(text: String):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = start_message
	$MessageLabel.show()
	$Joystick.hide()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$ConfigurationButton.show()
	$ExitButton.show()
	$VersionLabel.show()
	$HPBar.hide()


func update_score(score: int):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	$VersionLabel.hide()
	$ConfigurationButton.hide()
	$ExitButton.hide()
	$HPBar.show()
	if Global.has_joystick:
		$Joystick.show()
	emit_signal("game_started")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func set_hp_value(hp: int):
	$HPBar.value = hp


func _on_ConfigurationButton_pressed():
	emit_signal("configuration_opened")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_Config_sensitivity_changed():
	$Joystick.sensitivity = Global.joystick_sensitivity
