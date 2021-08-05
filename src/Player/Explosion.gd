extends Node2D

onready var ndExplosionAnimation := $ExplosionAnimation


func play():
	ndExplosionAnimation.current_animation = "Explode"
	ndExplosionAnimation.play()
