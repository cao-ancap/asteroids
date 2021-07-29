extends Control

signal dynamic_background_enabled(enabled)
signal sensitivity_changed

const laguages := [
	{"code": "pt_BR", "name": "Português (Brasil)"},
	{"code": "en_US", "name": "English (United States)"}
]


func _ready():
	$JoystickButton.pressed = Global.has_joystick
	update_joystick_status()
	$SensitivitySlider.value = Global.joystick_sensitivity
	for laguage in laguages:
		$LanguageButton.add_item(laguage["name"])

	select_language(0)


func _on_LanguageButton_item_selected(index: int):
	select_language(index)


func select_language(index: int):
	if laguages.size() > index:
		TranslationServer.set_locale(laguages[index]["code"])


func _on_CloseButton_pressed():
	hide()


func _on_BackgroundButton_toggled(enabled: bool):
	emit_signal("dynamic_background_enabled", enabled)


func _on_FullscreenButton_toggled(enabled: bool):
	OS.window_fullscreen = enabled


func update_joystick_status():
	if Global.has_joystick:
		$SensitivitySlider.editable = true
	else:
		$SensitivitySlider.editable = false


func _on_JoystickButton_toggled(enabled: bool):
	Global.has_joystick = enabled
	update_joystick_status()


func _on_SensitivitySlider_value_changed(value):
	Global.joystick_sensitivity = value
	emit_signal("sensitivity_changed")
