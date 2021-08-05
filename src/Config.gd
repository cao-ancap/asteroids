extends Node

const laguages := [
	{"code": "pt_BR", "name": "Português (Brasil)"},
	{"code": "en_US", "name": "English (United States)"}
]

var joystick_sensitivity := 60.0
var dynamic_background_enabled := false
var selected_laguage := 0

onready var has_joystick := not OS.get_name() in ["OSX", "Windows", "UWP", "X11"]


func select_language(index: int):
	if laguages.size() > index:
		selected_laguage = index
		TranslationServer.set_locale(laguages[index]["code"])
