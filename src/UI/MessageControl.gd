extends Control

const start_message := "Dodge the Asteroids"


func _ready():
	show_message(start_message)

func show_temp_message(text: String):
	show_message(text)
	$MessageTimer.start()

func show_message(text: String):
	$MessageLabel.text = text
	$MessageLabel.show()

func show_game_over():
	show_temp_message("Game Over")
	yield($MessageTimer, "timeout")
	show_message(start_message)


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
