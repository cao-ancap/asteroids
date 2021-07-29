extends CanvasLayer

signal game_started
signal configuration_opened

const start_message := "Dodge the Asteroids"


func _ready():
	$MessageLabel.text = start_message


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
	$VersionLabel.show()
	$ConfigurationButton.show()
	$HPBar.hide()


func update_score(score: int):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	$VersionLabel.hide()
	$ConfigurationButton.hide()
	$HPBar.show()
	emit_signal("game_started")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func set_hp_value(hp: int):
	$HPBar.value = hp


func _on_ConfigurationButton_pressed():
	emit_signal("configuration_opened")
