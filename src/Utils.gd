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


func calc_difficulty_to_hp(difficulty: int) -> int:
	return 10 - difficulty

func parse_date(iso_date: String) -> Dictionary:
	var date_time := iso_date.split("T")
	var date := date_time[0].split("-")
	var time := date_time[1].trim_suffix("Z").split(":")

	return {
		year = date[0],
		month = date[1],
		day = date[2],
		hour = time[0],
		minute = time[1],
		second = time[2],
	}


func iso_from_date_dict(date: Dictionary) -> String:
	return "%04d-%02d-%02dT%02d:%02d:%02d.000Z" % [date["year"] , date["month"] , date["day"] , date["hour"], date["minute"] , date["second"]]
