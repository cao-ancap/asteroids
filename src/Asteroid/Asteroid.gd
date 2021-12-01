extends RigidBody2D
class_name Asteroid

export var min_speed := 150.0
export var max_speed := 250.0
export var max_angular_speed := 8.0
export (Array, Texture) var textures

onready var ndHitSound := $HitSound
onready var ndSprite := $Sprite
onready var ndParticles2D := $Particles2D


func _ready():
	var type: int = randi() % textures.size()
	ndSprite.texture = textures[type]
	angular_velocity = rand_range(-max_angular_speed, max_angular_speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Asteroid_body_entered(_body: Node):
	ndHitSound.random_pitch_play()
	ndParticles2D.emitting = true
