extends ParallaxLayer

export var base_world_speed := 0

var world_speed := 0.0


func _ready():
	motion_offset.x = rand_range(0, 1024)
	var margin := base_world_speed / rand_range(3, 10)
	world_speed = base_world_speed + rand_range(margin, -margin)
	$Sprite.flip_h = Global.rand_bool()
	$Sprite.flip_v = Global.rand_bool()


func _process(delta: float):
	motion_offset.x += world_speed * delta
