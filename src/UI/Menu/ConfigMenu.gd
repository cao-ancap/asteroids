extends Control

signal dynamic_background_changed
signal joystick_changed
signal sensitivity_changed
signal difficulty_changed

var is_ready := false

onready var ndJoystickButton := $JoystickButton
onready var ndSensitivitySlider := $SensitivitySlider
onready var ndDifficultySlider := $DifficultySlider
onready var ndMasterVolumeSlider := $MasterVolumeSlider
onready var ndMusicVolumeSlider := $MusicVolumeSlider
onready var ndEffectVolumeSlider := $EffectVolumeSlider
onready var ndBackgroundButton := $BackgroundButton
onready var ndFullscreenButton := $FullscreenButton
onready var ndLanguageButton := $LanguageButton


func _ready():
	ndJoystickButton.pressed = Config.has_joystick
	update_joystick_submenu_status()
	ndSensitivitySlider.value = Config.joystick_sensitivity
	ndDifficultySlider.value = Config.difficulty
	ndMasterVolumeSlider.value = Config.master_volume
	ndMusicVolumeSlider.value = Config.music_volume
	ndEffectVolumeSlider.value = Config.effect_volume
	ndBackgroundButton.pressed = Config.dynamic_background_enabled
	ndFullscreenButton.pressed = Config.fullscreen
	for laguage in Config.LANGUAGES:
		ndLanguageButton.add_item(laguage["name"])

	ndLanguageButton.selected = Config.selected_laguage

	Config.select_language(Config.selected_laguage)

	is_ready = true


func _on_LanguageButton_item_selected(index: int):
	Config.select_language(index)


func _on_CloseButton_pressed():
	Config.save()
	hide()


func _on_BackgroundButton_toggled(enabled: bool):
	Config.dynamic_background_enabled = enabled
	if is_ready:
		emit_signal("dynamic_background_changed")


func _on_FullscreenButton_toggled(enabled: bool):
	Config.set_fullscreen(enabled)


func update_joystick_submenu_status():
	if Config.has_joystick:
		ndSensitivitySlider.editable = true
	else:
		ndSensitivitySlider.editable = false


func _on_JoystickButton_toggled(enabled: bool):
	Config.has_joystick = enabled
	update_joystick_submenu_status()
	if is_ready:
		emit_signal("joystick_changed")


func _on_SensitivitySlider_value_changed(value: int):
	Config.joystick_sensitivity = value
	if is_ready:
		emit_signal("sensitivity_changed")


func _on_DifficultySlider_value_changed(value: int):
	Config.difficulty = value
	if is_ready:
		emit_signal("difficulty_changed")


func _on_MasterVolumeSlider_value_changed(value: int):
	Config.master_volume = value
	AudioServer.set_bus_volume_db(Config.master_volume_index, value)


func _on_MusicVolumeSlider_value_changed(value: int):
	Config.music_volume = value
	AudioServer.set_bus_volume_db(Config.music_volume_index, value)


func _on_EffectVolumeSlider_value_changed(value: int):
	Config.effect_volume = value
	AudioServer.set_bus_volume_db(Config.effect_volume_index, value)
