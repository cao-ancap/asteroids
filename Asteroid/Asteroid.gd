extends RigidBody2D

export var min_speed := 150.0
export var max_speed := 250.0
export var max_angular_speed := 8.0
export (Array, Texture) var textures


func _ready():
	var type: int = randi() % textures.size()
	$Sprite.texture = textures[type]
	angular_velocity = rand_range(-max_angular_speed, max_angular_speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Asteroid_body_entered(_body: Node):
	$HitSound.random_pitch_play()
