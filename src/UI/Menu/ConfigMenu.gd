extends Control

signal dynamic_background_changed
signal joystick_changed
signal sensitivity_changed


func _ready():
	$JoystickButton.pressed = Config.has_joystick
	update_joystick_submenu_status()
	$SensitivitySlider.value = Config.joystick_sensitivity
	$BackgroundButton.pressed = Config.dynamic_background_enabled
	$FullscreenButton.pressed = OS.window_fullscreen
	for laguage in Config.laguages:
		$LanguageButton.add_item(laguage["name"])

	Config.select_language(Config.selected_laguage)


func _on_LanguageButton_item_selected(index: int):
	Config.select_language(index)


func _on_CloseButton_pressed():
	hide()


func _on_BackgroundButton_toggled(enabled: bool):
	Config.dynamic_background_enabled = enabled
	emit_signal("dynamic_background_changed")


func _on_FullscreenButton_toggled(enabled: bool):
	OS.window_fullscreen = enabled


func update_joystick_submenu_status():
	if Config.has_joystick:
		$SensitivitySlider.editable = true
	else:
		$SensitivitySlider.editable = false


func _on_JoystickButton_toggled(enabled: bool):
	Config.has_joystick = enabled
	update_joystick_submenu_status()
	emit_signal("joystick_changed")


func _on_SensitivitySlider_value_changed(value):
	Config.joystick_sensitivity = value
	emit_signal("sensitivity_changed")
