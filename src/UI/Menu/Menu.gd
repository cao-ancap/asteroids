extends Panel

signal game_started
signal configuration_opened
signal credits_opened


func _ready():
	$VersionLabel.text = "v" + Utils.version
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



func _on_StartButton_pressed():
	emit_signal("game_started")
	hide()


func _on_ConfigurationButton_pressed():
	emit_signal("configuration_opened")


func _on_CreditsButton_pressed():
	emit_signal("credits_opened")


func _on_ExitButton_pressed():
	get_tree().quit()
