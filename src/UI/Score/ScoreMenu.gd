extends Panel

onready var scoreService := ScoreService.new()
onready var ndListVBoxContainer := $ScrollContainer/ListVBoxContainer
onready var ndCloseButton := $CloseButton

export var score_line_scene: PackedScene


func _ready():
	add_child(scoreService)
	var error := scoreService.connect("get_request_completed", self, "_on_get_request_completed")
	if error != OK:
		push_error("An error occurred at event connect.")
	refresh_list()


func refresh_list():
	scoreService.get_scores()


func _on_get_request_completed(_result, _response_code, _headers, body):
	var json := JSON.parse(body.get_string_from_utf8())
	fill_score_list(json.result)


func fill_score_list(data: Array):
	clear_scores()
	for i in range(data.size()):
		var item: ScoreLine = score_line_scene.instance()
		var score: Dictionary = data[i]
		item.classification = i + 1
		item.player_name = score["playerName"]
		item.score = score["score"]
		item.date = score["creationDate"]
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
