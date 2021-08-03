extends Node

const version := "0.0.9a"

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
