extends Node

export(Array, PackedScene) var asteroid_scenes := []
export var world_speed := -50.0

var status := GameStatus.new()

onready var ndPlayer := $Player
onready var ndStartPosition := $StartPosition
onready var ndHUD := $HUD
onready var ndAsteroidPath := $AsteroidPath
onready var ndAsteroidSpawnLocation := $AsteroidPath/AsteroidSpawnLocation
onready var ndMenu := $Menu
onready var ndConfig := $Menu/Config
onready var ndCredits := $Menu/Credits
onready var ndScoreboard := $Menu/Scoreboard
onready var ndScoreSend := $Menu/ScoreSend
onready var ndMessageControl := $MessageControl
onready var ndStartTimer := $StartTimer
onready var ndScoreTimer := $ScoreTimer
onready var ndAsteroidTimer := $AsteroidTimer
onready var ndBackgroundMusic := $BackgroundMusic
onready var ndStarfield := $Starfield
onready var ndStarfieldParallax := $StarfieldParallax
onready var ndPauseMenu := $PauseMenu


func _ready():
	randomize()
	config_dynamic_background()
	ndPlayer.joystick = ndHUD.ndJoystick


func _on_Menu_game_started():
	ndScoreTimer.wait_time = 1.0 / (Config.difficulty + 1)
	get_tree().call_group("asteroids", "queue_free")
	status.start_game()
	ndPlayer.world_speed = world_speed
	ndPlayer.start(ndStartPosition.position)
	ndStartTimer.start()
	ndHUD.update_score(status.get_score())
	ndHUD.show()
	ndMessageControl.show_temp_message("Get Ready")
	ndBackgroundMusic.play()


func game_over(exit_game := false):
	ndStartTimer.stop()
	ndScoreTimer.stop()
	ndAsteroidTimer.stop()
	if not exit_game:
		status.end_game()
		ndMessageControl.show_game_over()
		yield(get_tree().create_timer(2), "timeout")
	ndBackgroundMusic.stop()
	ndHUD.hide()
	if exit_game:
		ndMenu.show_buttons()
	else:
		ndMenu.hide_buttons()
		ndScoreSend.show_menu(status.duplicate())
	ndMenu.show()


func _on_ScoreTimer_timeout():
	ndHUD.update_score(status.increment_score())


func _on_StartTimer_timeout():
	ndAsteroidTimer.start()
	ndScoreTimer.start()


func _on_AsteroidTimer_timeout():
	ndAsteroidSpawnLocation.offset = randi()

	var asteroid_count := asteroid_scenes.size()
	if not asteroid_count:
		return

	var type := randi() % asteroid_count
	var asteroid_scene: PackedScene = asteroid_scenes[type]

	var asteroid: Asteroid = asteroid_scene.instance()
	add_child_below_node(ndAsteroidPath, asteroid)

	asteroid.position = ndAsteroidSpawnLocation.position

	var direction: float = (
		ndAsteroidSpawnLocation.rotation
		+ rand_range(Utils.RAD_045_GRAUS, Utils.RAD_135_GRAUS)
	)
	var velocity := Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = velocity.rotated(direction)


func _on_Player_hp_updated(hp):
	ndHUD.set_hp_value(hp)


func _on_Player_died():
	game_over()


func _on_Menu_configuration_opened():
	ndConfig.show()
	ndConfig.ndLanguageButton.grab_focus()
	ndMenu.hide_buttons()


func _on_Config_hide():
	ndMenu.show_buttons()
	ndMenu.ndConfigurationButton.grab_focus()


func _on_Menu_credits_opened():
	ndCredits.show()
	ndCredits.ndCloseButton.grab_focus()
	ndMenu.hide_buttons()


func _on_Credits_hide():
	ndMenu.show_buttons()
	ndMenu.ndCreditsButton.grab_focus()


func _on_Menu_scoreboard_opened():
	ndScoreboard.show()
	ndScoreboard.ndCloseButton.grab_focus()
	ndMenu.hide_buttons()


func _on_Scoreboard_hide():
	ndMenu.show_buttons()
	ndMenu.ndScoreboardButton.grab_focus()


func _on_ScoreSend_hide():
	ndMenu.show_buttons()
	ndMenu.ndScoreboardButton.grab_focus()


func _on_Config_joystick_changed():
	ndHUD.update_joystick()


func _on_Config_sensitivity_changed():
	ndHUD.update_joystick_sensitivity()


func _on_Config_dynamic_background_changed():
	config_dynamic_background()


func config_dynamic_background():
	if Config.dynamic_background_enabled:
		ndStarfield.start(world_speed)
		ndStarfieldParallax.stop()
	else:
		ndStarfield.stop()
		ndStarfieldParallax.start(world_speed)


func _on_Config_difficulty_changed():
	ndHUD.reconfig_hp_bar()


func _on_ScoreSend_score_registered():
	yield(get_tree().create_timer(0.5), "timeout")
	ndMenu.show_scoreboard()


func _on_PauseMenu_quited():
	toggle_pause()
	ndPlayer.set_dead()
	game_over(true)


func _on_HUD_paused():
	toggle_pause()
	ndPauseMenu.show()


func _on_PauseMenu_resumed():
	toggle_pause()


func toggle_pause():
	get_tree().paused = not get_tree().paused
