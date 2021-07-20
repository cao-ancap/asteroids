extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

export(Array, Texture) var textures

func _ready():
	var type = randi() % textures.size()
	$Sprite.texture = textures[type]
	angular_velocity = (randf() - 0.5) * 16

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_start_game():
	queue_free()
