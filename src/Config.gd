extends Node

const LANGUAGES := [
	{code = "pt_BR", name = "Português (Brasil)"},
	{code = "en_US", name = "English (United States)"}
]

const CONF_FILE := "user://conf.json"

var joystick_sensitivity := 60.0
var dynamic_background_enabled := false
var selected_laguage := 0
var difficulty := 7
var master_volume := 0
var music_volume := 0
var effect_volume := 0
var fullscreen := false

var player_name := ""

onready var has_joystick := not OS.get_name() in ["OSX", "Windows", "UWP", "X11"]
onready var master_volume_index := AudioServer.get_bus_index("Master")
onready var music_volume_index := AudioServer.get_bus_index("Music")
onready var effect_volume_index := AudioServer.get_bus_index("Effect")


func _ready():
	load_config()
	AudioServer.set_bus_volume_db(master_volume_index, master_volume)
	AudioServer.set_bus_volume_db(music_volume_index, music_volume)
	AudioServer.set_bus_volume_db(effect_volume_index, effect_volume)
	OS.window_fullscreen = fullscreen


func select_language(index: int):
	if LANGUAGES.size() > index:
		selected_laguage = index
		TranslationServer.set_locale(LANGUAGES[index]["code"])


func set_fullscreen(enabled: bool):
	fullscreen = enabled
	OS.window_fullscreen = enabled


func save():
	var save_game := File.new()
	var error := save_game.open(CONF_FILE, File.WRITE)
	if error != OK:
		push_error("An error occurred on save file.")
		return
	var data := {
		joystickSensitivity = joystick_sensitivity,
		dynamicBackgroundEnabled = dynamic_background_enabled,
		selectedLaguage = selected_laguage,
		difficulty = difficulty,
		masterVolume = master_volume,
		musicVolume = music_volume,
		effectVolume = effect_volume,
		playerName = player_name,
		hasJoystick = has_joystick,
		fullscreen = false if Utils.is_web() else fullscreen
	}
	save_game.store_line(to_json(data))
	save_game.close()


func load_config():
	var save_game := File.new()
	if not save_game.file_exists(CONF_FILE):
		return
	var error := save_game.open(CONF_FILE, File.READ)
	if error != OK:
		push_error("An error occurred on load file.")
		return
	var data = parse_json(save_game.get_line())
	save_game.close()

	joystick_sensitivity = data.joystickSensitivity
	dynamic_background_enabled = data.dynamicBackgroundEnabled
	selected_laguage = data.selectedLaguage
	difficulty = data.difficulty
	master_volume = data.masterVolume
	music_volume = data.musicVolume
	effect_volume = data.effectVolume
	player_name = data.playerName
	has_joystick = data.hasJoystick
	fullscreen = data.fullscreen
