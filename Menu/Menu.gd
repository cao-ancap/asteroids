extends CanvasLayer

signal start_game

const start_message = "Dodge the Asteroids"

const laguages = [
	{"code": "pt_BR", "name": "Português (Brasil)"},
	{"code": "en_US", "name": "English (United States)"}
]

func _ready():
	$MessageLabel.text = start_message
	for laguage in laguages:
		$LanguageButton.add_item(laguage["name"])
	
	_on_LanguageButton_item_selected(0)

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
	$LanguageButton.show()
	$VersionLabel.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	$LanguageButton.hide()
	$VersionLabel.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_LanguageButton_item_selected(index):
	if laguages.size() > index:
		TranslationServer.set_locale(laguages[index]["code"])
