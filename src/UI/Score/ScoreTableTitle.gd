extends ScoreLine

export var classification_str := ""
export var player_str := ""
export var score_str := ""
export var date_str := ""


func _ready():
	set_classification_str(classification_str)
	set_player_str(player_str)
	set_score_str(score_str)
	set_date_str(date_str)
