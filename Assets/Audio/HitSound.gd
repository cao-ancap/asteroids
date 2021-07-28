extends AudioStreamPlayer

export var pitch_min := 0.85
export var pitch_max := 1.25


func random_pitch_play():
	pitch_scale = rand_range(pitch_min, pitch_max)
	play()
	yield(self, "finished")
	pitch_scale = 1
