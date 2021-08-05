extends Node2D

export var star_layer_scene: PackedScene
export var density := 2

var layers := []

onready var ndParallaxBackground := $ParallaxBackground


func start(world_speed):
	stop()
	for _i in range(density):
		var star_layer: ParallaxLayer = star_layer_scene.instance()
		star_layer.base_world_speed = world_speed
		layers.append(star_layer)
		ndParallaxBackground.add_child(star_layer)


func stop():
	for layer in layers:
		ndParallaxBackground.remove_child(layer)
		layer.queue_free()

	layers = []
