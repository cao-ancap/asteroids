extends RigidBody2D

export var min_speed := 150.0
export var max_speed := 250.0

export (Array, Texture) var textures


func _ready():
	var type: int = randi() % textures.size()
	$Sprite.texture = textures[type]
	angular_velocity = (randf() - 0.5) * 16


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Asteroid_body_entered(_body: Node):
	$HitSound.random_pitch_play()
