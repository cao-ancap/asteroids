extends Control

signal dynamic_background_changed
signal joystick_changed
signal sensitivity_changed


func _ready():
	$JoystickButton.pressed = Global.has_joystick
	update_joystick_submenu_status()
	$SensitivitySlider.value = Global.joystick_sensitivity
	$BackgroundButton.pressed = Global.dynamic_background_enabled
	$FullscreenButton.pressed = OS.window_fullscreen
	for laguage in Global.laguages:
		$LanguageButton.add_item(laguage["name"])

	Global.select_language(Global.selected_laguage)


func _on_LanguageButton_item_selected(index: int):
	Global.select_language(index)


func _on_CloseButton_pressed():
	hide()


func _on_BackgroundButton_toggled(enabled: bool):
	Global.dynamic_background_enabled = enabled
	emit_signal("dynamic_background_changed")


func _on_FullscreenButton_toggled(enabled: bool):
	OS.window_fullscreen = enabled


func update_joystick_submenu_status():
	if Global.has_joystick:
		$SensitivitySlider.editable = true
	else:
		$SensitivitySlider.editable = false


func _on_JoystickButton_toggled(enabled: bool):
	Global.has_joystick = enabled
	update_joystick_submenu_status()
	emit_signal("joystick_changed")


func _on_SensitivitySlider_value_changed(value):
	Global.joystick_sensitivity = value
	emit_signal("sensitivity_changed")
