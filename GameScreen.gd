extends Node

export (PackedScene) var asteroid_scene

var score = 0

func _ready():
	randomize()

func _on_Menu_start_game():
	get_tree().call_group("asteroids", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Menu.update_score(score)
	$Menu.show_message("Get Ready")

func game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	$Menu.show_game_over()

func _on_ScoreTimer_timeout():
	score += 1
	$Menu.update_score(score)

func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()
	
const degree_90 = PI / 2
const degree_45 = PI / 4

func _on_AsteroidTimer_timeout():
	var asteroid_spawn_location = $"AsteroidPath/AsteroidSpawnLocation"
	
	asteroid_spawn_location.offset = randi()

	var asteroid = asteroid_scene.instance()
	add_child(asteroid)

	asteroid.position = asteroid_spawn_location.position

	var direction = asteroid_spawn_location.rotation + degree_90 + rand_range(-degree_45, degree_45)

	var velocity = Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = velocity.rotated(direction)
