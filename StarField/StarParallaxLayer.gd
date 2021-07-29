extends ParallaxLayer

export var base_world_speed := 0

var world_speed := 0.0

func _ready():
	motion_offset.x = rand_range(0, 1024)
	world_speed = base_world_speed + rand_range(-base_world_speed / 10, base_world_speed / 10)

func _process(delta: float):
	motion_offset.x += world_speed * delta
