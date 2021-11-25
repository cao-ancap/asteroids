extends Panel

signal game_started
signal configuration_opened
signal credits_opened
signal scoreboard_opened

onready var ndVersionLabel := $VersionLabel
onready var ndStartButton := $StartButton
onready var ndConfigurationButton := $ConfigurationButton
onready var ndCreditsButton := $CreditsButton
onready var ndScoreboardButton := $ScoreboardButton
onready var ndExitButton := $ExitButton


func _ready():
	ndVersionLabel.text = "v" + Utils.version
	ndStartButton.grab_focus()
	show_exit_button()


func show_buttons():
	ndStartButton.show()
	ndConfigurationButton.show()
	ndCreditsButton.show()
	ndScoreboardButton.show()
	show_exit_button()


func hide_buttons():
	ndStartButton.hide()
	ndConfigurationButton.hide()
	ndScoreboardButton.hide()
	ndExitButton.hide()


func show_exit_button():
	if Utils.is_web():
		ndExitButton.hide()
	else:
		ndExitButton.show()


func _on_StartButton_pressed():
	emit_signal("game_started")
	hide()


func _on_ConfigurationButton_pressed():
	emit_signal("configuration_opened")


func _on_CreditsButton_pressed():
	emit_signal("credits_opened")


func _on_ScoreboardButton_pressed():
	emit_signal("scoreboard_opened")


func _on_ExitButton_pressed():
	get_tree().quit()
