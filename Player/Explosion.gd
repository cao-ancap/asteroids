extends Node2D


func play():
	$ExplosionAnimation.current_animation = "Explode"
	$ExplosionAnimation.play()
