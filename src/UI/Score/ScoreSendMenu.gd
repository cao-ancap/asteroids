extends Panel

signal score_registered

onready var scoreService := ScoreService.new()
onready var ndSendButton := $SendButton
onready var ndCloseButton := $CloseButton
onready var ndLoadingTextureRect := $LoadingTextureRect
onready var ndPlayerNameLineEdit := $PlayerNameLineEdit
onready var ndErrorAcceptDialog := $ErrorAcceptDialog

var _score: GameStatus


func _ready():
	add_child(scoreService)
	var error := scoreService.connect("post_request_completed", self, "_on_post_request_completed")
	if error != OK:
		push_error("An error occurred at event connect.")


func show_menu(score: GameStatus):
	_score = score
	ndPlayerNameLineEdit.text = score.get_player_name()
	show()


func set_loading(loading := true):
	ndSendButton.disabled = loading
	ndCloseButton.disabled = loading
	ndLoadingTextureRect.visible = loading


func _on_post_request_completed(_result, response_code, _headers, _body):
	set_loading(false)
	hide()
	if response_code < 400:
		emit_signal("score_registered")
	else:
		ndErrorAcceptDialog.dialog_text = "There was an error sending the score!"
		ndErrorAcceptDialog.popup_centered()


func _on_CloseButton_pressed():
	set_loading(false)
	hide()


func _on_SendButton_pressed():
	set_loading(true)
	_score.set_player_name(ndPlayerNameLineEdit.text)
	Config.player_name = ndPlayerNameLineEdit.text
	scoreService.send_score(_score.get_status())
