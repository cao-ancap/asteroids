extends CanvasLayer

signal start_game

const start_message = "Dodge the Asteroids"

func _ready():
	$MessageLabel.text = start_message

func show_message(text):
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

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	$VersionLabel.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
