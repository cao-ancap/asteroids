extends Panel

signal game_started
signal configuration_opened
signal credits_opened

const start_message := "Dodge the Asteroids"


func _ready():
	$VersionLabel.text = 'v' + Utils.version
	$MessageLabel.text = start_message
	$StartButton.grab_focus()
	show_exit_button()

func show_buttons():
	$StartButton.show()
	$ConfigurationButton.show()
	$CreditsButton.show()
	show_exit_button()

func hide_buttons():
	$StartButton.hide()
	$ConfigurationButton.hide()
	$CreditsButton.hide()
	$ExitButton.hide()


func show_exit_button():
	if Utils.is_web:
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
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$ConfigurationButton.show()
	$VersionLabel.show()
	show_exit_button()


func _on_StartButton_pressed():
	$StartButton.hide()
	$ConfigurationButton.hide()
	$ExitButton.hide()
	$VersionLabel.hide()
	emit_signal("game_started")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_ConfigurationButton_pressed():
	emit_signal("configuration_opened")


func _on_CreditsButton_pressed():
	emit_signal("credits_opened")


func _on_ExitButton_pressed():
	get_tree().quit()
