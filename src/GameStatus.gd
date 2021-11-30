class_name GameStatus

var _player_name := "" setget set_player_name, get_player_name
var _score := 0 setget , get_score
var _start_time: Dictionary
var _end_time: Dictionary
var _game_ended := false


func start_game():
	_player_name = Config.player_name
	_score = 0
	_start_time = OS.get_datetime(true)
	_end_time.clear()
	_game_ended = false


func end_game():
	if not _game_ended:
		_end_time = OS.get_datetime(true)
		_game_ended = true


func increment_score() -> int:
	_score += 1
	return _score


func get_score() -> int:
	return _score


func set_player_name(player_name: String):
	_player_name = player_name


func get_player_name() -> String:
	return _player_name


func game_ended() -> bool:
	return not _end_time.empty()


func get_status() -> Dictionary:
	if _game_ended:
		return {
			playerName = _player_name,
			score = _score,
			startTime = Utils.iso_from_date_dict(_start_time),
			endTime = Utils.iso_from_date_dict(_end_time)
		}
	return {}


func duplicate() -> GameStatus:
	var status: GameStatus = get_script().new()
	status._player_name = _player_name
	status._score = _score
	status._start_time = _start_time
	status._end_time = _end_time
	status._game_ended = _game_ended
	return status
