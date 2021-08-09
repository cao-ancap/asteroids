extends AudioStreamPlayer
class_name RandomAudioStreamPlayer

export var pitch_min := 0.85
export var pitch_max := 1.25

onready var next_random_pitch := get_random_pitch()


func random_pitch_play():
	pitch_scale = next_random_pitch
	play()
	yield(self, "finished")
	pitch_scale = 1
	next_random_pitch = get_random_pitch()


func get_random_pitch() -> float:
	return rand_range(pitch_min, pitch_max)
