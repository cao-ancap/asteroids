extends Node

export var asteroid_scene: PackedScene
export var world_speed := -50.0

var score := 0


func _ready():
	config_dynamic_background()
	$Player.joystick = $HUD/Joystick


func _on_Menu_game_started():
	get_tree().call_group("asteroids", "queue_free")
	score = 0
	$Player.world_speed = world_speed
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show()
	$Menu.show_message("Get Ready")
	$BackgroundMusic.play()


func game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	$Menu.show_game_over()
	$BackgroundMusic.stop()
	$HUD.hide()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()


func _on_AsteroidTimer_timeout():
	var asteroid_spawn_location := $"AsteroidPath/AsteroidSpawnLocation"

	asteroid_spawn_location.offset = randi()

	var asteroid: RigidBody2D = asteroid_scene.instance()
	add_child(asteroid)

	asteroid.position = asteroid_spawn_location.position

	var direction: float = (
		asteroid_spawn_location.rotation
		+ rand_range(Global.RAD_045_GRAUS, Global.RAD_135_GRAUS)
	)
	var velocity := Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = velocity.rotated(direction)


func _on_Player_hp_updated(hp):
	$HUD.set_hp_value(hp)


func _on_Player_died():
	game_over()


func _on_Menu_configuration_opened():
	$Menu/Config.show()
	$Menu/Config/LanguageButton.grab_focus()
	$Menu/StartButton.hide()
	$Menu/ConfigurationButton.hide()


func _on_Config_hide():
	$Menu/StartButton.show()
	$Menu/ConfigurationButton.show()
	$Menu/ConfigurationButton.grab_focus()

func _on_Config_joystick_changed():
	$HUD.update_joystick()
		

func _on_Config_sensitivity_changed():
	$HUD.update_joystick_sensitivity()


func _on_Config_dynamic_background_changed():
	config_dynamic_background()
	
func config_dynamic_background():
	if Global.dynamic_background_enabled:
		$Starfield.start(world_speed)
		$StarfieldParallax.stop()
	else:
		$Starfield.stop()
		$StarfieldParallax.start(world_speed)
