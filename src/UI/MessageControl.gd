extends Control

const START_MESSAGE := "Dodge the Asteroids"

onready var ndMessageTimer := $MessageTimer
onready var ndMessageLabel := $MessageLabel


func _ready():
	show_message(START_MESSAGE)


func show_temp_message(text: String):
	show_message(text)
	ndMessageTimer.start()


func show_message(text: String):
	ndMessageLabel.text = text
	ndMessageLabel.show()


func show_game_over():
	show_temp_message("Game Over")
	yield(ndMessageTimer, "timeout")
	show_message(START_MESSAGE)


func _on_MessageTimer_timeout():
	ndMessageLabel.hide()
