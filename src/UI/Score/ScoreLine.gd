class_name ScoreLine
extends HBoxContainer

export var _classification := 0
export var _player_name := ""
export var _score := 0
export var _date := ""

onready var ndClassificationLabel := $ClassificationLabel
onready var ndPlayerNameLabel := $PlayerNameLabel
onready var ndScoreLabel := $ScoreLabel
onready var ndDateLabel := $DateLabel


func _ready():
	set_classification(_classification)
	set_player_name(_player_name)
	set_score(_score)
	set_date(_date)


func set_classification(classification: int):
	_classification = classification
	yield(self, "ready")
	ndClassificationLabel.text = str(classification)


func set_player_name(player_name: String):
	_player_name = player_name
	yield(self, "ready")
	ndPlayerNameLabel.text = player_name


func set_score(score: int):
	_score = score
	yield(self, "ready")
	ndScoreLabel.text = str(score)


func set_date(date: String):
	_date = date
	yield(self, "ready")
	ndDateLabel.text = Utils.get_date_locale_string(date)
