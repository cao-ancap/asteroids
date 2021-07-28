extends Node

export var asteroid_scene: PackedScene

export var world_speed := -50.0

var score := 0


func _ready():
	randomize()
	$Starfield.process_material.set("initial_velocity", world_speed)


func _on_Menu_start_game():
	get_tree().call_group("asteroids", "queue_free")
	score = 0
	$Player.world_speed = world_speed
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Menu.update_score(score)
	$Menu.show_message("Get Ready")
	$BackgroundMusic.play()


func game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	$Menu.show_game_over()
	$BackgroundMusic.stop()


func _on_ScoreTimer_timeout():
	score += 1
	$Menu.update_score(score)


func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()


const degree_90 := PI / 2
const degree_45 := PI / 4


func _on_AsteroidTimer_timeout():
	var asteroid_spawn_location := $"AsteroidPath/AsteroidSpawnLocation"

	asteroid_spawn_location.offset = randi()

	var asteroid: RigidBody2D = asteroid_scene.instance()
	add_child(asteroid)

	asteroid.position = asteroid_spawn_location.position

	var direction: float = (
		asteroid_spawn_location.rotation
		+ degree_90
		+ rand_range(-degree_45, degree_45)
	)
	var velocity := Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = velocity.rotated(direction)


func _on_Player_new_hp(hp):
	$Menu.set_hp_value(hp)
