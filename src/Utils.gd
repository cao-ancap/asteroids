extends Node

const version := "0.0.10b"

const RAD_000_GRAUS := deg2rad(0)
const RAD_045_GRAUS := deg2rad(45)
const RAD_090_GRAUS := deg2rad(90)
const RAD_135_GRAUS := deg2rad(135)
const RAD_180_GRAUS := deg2rad(180)
const RAD_225_GRAUS := deg2rad(225)
const RAD_270_GRAUS := deg2rad(270)
const RAD_315_GRAUS := deg2rad(315)

onready var is_web := OS.get_name() == "HTML5"


func _ready():
	randomize()


func rand_signal() -> int:
	return (randi() & 2) - 1


func rand_bool() -> bool:
	return true if randi() & 1 else false


func calc_difficulty_to_hp(difficulty: int):
	return 10 - difficulty


func create_signed_json(dict: Dictionary) -> String:
	dict["_n"] = randi()
	dict["_h"] = salt_hash(dict)
	return JSON.print(dict)


func salt_hash(dict: Dictionary) -> String:
	var o := dict.duplicate()
	o["_n"] = calc_salt(o["_n"] if o["_n"] and o["_n"] != 0 else 249)
	o["_ns"] = calc_salt(4651)
	o["_ts"] = "dfjksduhajsnduygzyxndcowicxzujnqwbfuygysc"
	return JSON.print(o).sha256_text()


func calc_salt(n: float) -> String:
	var x := sin(n) * 10000
	var ac := acos(n) if n > -1 and n < 1 else acos(1 / n)
	return "%0.10f" % (x + ac)
