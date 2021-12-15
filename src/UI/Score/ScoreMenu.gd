extends Panel

export var score_line_scene: PackedScene

onready var score_service := ScoreService.new()
onready var ndListVBoxContainer := $ScrollContainer/ListVBoxContainer
onready var ndCloseButton := $CloseButton
onready var ndLoadingTextureRect := $LoadingTextureRect


func _ready():
	add_child(score_service)
	var error := score_service.connect("get_request_completed", self, "_on_get_request_completed")
	if error != OK:
		push_error("An error occurred at event connect.")


func refresh_list():
	set_loading(true)
	score_service.get_scores()


func set_loading(loading := true):
	ndLoadingTextureRect.visible = loading


func _on_get_request_completed(_result, response_code, _headers, body):
	if response_code < 400:
		var json := JSON.parse(body.get_string_from_utf8())
		fill_score_list(json.result)

	set_loading(false)


func fill_score_list(data: Array):
	clear_scores()
	for i in range(data.size()):
		var item: ScoreLine = score_line_scene.instance()
		var score: Dictionary = data[i]
		item.set_classification(i + 1)
		item.set_player_name(score["playerName"])
		item.set_score(score["score"])
		item.set_date(score["creationDate"])
		ndListVBoxContainer.add_child(item)


func clear_scores():
	get_tree().call_group("scores", "queue_free")


func _on_CloseButton_pressed():
	hide()


func _on_ScoreMenu_visibility_changed():
	if visible:
		refresh_list()
	else:
		clear_scores()
