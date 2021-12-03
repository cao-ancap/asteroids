class_name Utils

const version := "0.1.2"

const RAD_000_GRAUS := deg2rad(0)
const RAD_045_GRAUS := deg2rad(45)
const RAD_090_GRAUS := deg2rad(90)
const RAD_135_GRAUS := deg2rad(135)
const RAD_180_GRAUS := deg2rad(180)
const RAD_225_GRAUS := deg2rad(225)
const RAD_270_GRAUS := deg2rad(270)
const RAD_315_GRAUS := deg2rad(315)

static func is_web() -> bool:
	return OS.get_name() == "HTML5"

static func rand_signal() -> int:
	return (randi() & 2) - 1

static func rand_bool() -> bool:
	return true if randi() & 1 else false

static func calc_difficulty_to_hp(difficulty: int) -> int:
	return 10 - difficulty

static func parse_date(iso_date: String) -> Dictionary:
	var date_time := iso_date.split("T")
	var date := date_time[0].split("-")
	var time := date_time[1].trim_suffix("Z").split(":")

	return {
		year = int(date[0]),
		month = int(date[1]),
		day = int(date[2]),
		hour = int(time[0]),
		minute = int(time[1]),
		second = int(time[2])
	}

static func get_date_locale_string(iso_date: String) -> String:
	var date := parse_date(iso_date)
	var locale := TranslationServer.get_locale()
	match locale:
		"pt_BR":
			return "%02d/%02d/%04d" % [date["day"], date["month"], date["year"]]
		_:
			return "%04d-%02d-%02d" % [date["year"], date["month"], date["day"]]

static func parse_date_to_unix_time(iso_date: String) -> int:
	return OS.get_unix_time_from_datetime(parse_date(iso_date))

static func parse_date_full(iso_date: String) -> Dictionary:
	return OS.get_datetime_from_unix_time(OS.get_unix_time_from_datetime(parse_date(iso_date)))

static func iso_from_date_dict(date: Dictionary) -> String:
	return (
		"%04d-%02d-%02dT%02d:%02d:%02d.000Z"
		% [date["year"], date["month"], date["day"], date["hour"], date["minute"], date["second"]]
	)
