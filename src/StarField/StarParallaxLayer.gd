extends ParallaxLayer

export var base_world_speed := 0

var world_speed := 0.0

onready var ndSprite := $Sprite


func _ready():
	motion_offset.x = rand_range(0, 1024)
	var margin := base_world_speed / rand_range(3, 10)
	world_speed = base_world_speed + rand_range(margin, -margin)
	ndSprite.flip_h = Utils.rand_bool()
	ndSprite.flip_v = Utils.rand_bool()


func _process(delta: float):
	motion_offset.x += world_speed * delta
