extends HBoxContainer
class_name ScoreLine

onready var ndClassificationLabel := $ClassificationLabel
onready var ndPlayerNameLabel := $PlayerNameLabel
onready var ndScoreLabel := $ScoreLabel
onready var ndDateLabel := $DateLabel

export var classification := 0
export var player_name := ""
export var score := 0
export var date := ""


func _ready():
	set_classification(classification)
	set_player_name(player_name)
	set_score(score)
	set_date(date)


func set_classification(classification: int):
	ndClassificationLabel.text = str(classification)


func set_player_name(player_name: String):
	ndPlayerNameLabel.text = player_name


func set_score(score: int):
	ndScoreLabel.text = str(score)


func set_date(date: String):
	ndDateLabel.text = Utils.get_date_locale_string(date)
