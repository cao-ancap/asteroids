extends RigidBody2D

signal died
signal hp_updated(hp)
signal immune_enabled

export var max_speed := 450.0
export var world_speed := 0.0

var joystick: Joystick

var hp: int

var screen_size: Vector2
var speed := Vector2.ZERO
var start_pos := Vector2.ZERO

var reset := false
var processing := false

var immune := false

onready var ndHitSound := $HitSound
onready var ndExplosion := $Explosion
onready var ndParticles2DR := $Particles2DR
onready var ndParticles2DL := $Particles2DL
onready var ndCollisionPolygon2D := $CollisionPolygon2D
onready var ndSprite := $Sprite


func _ready():
	screen_size = get_viewport_rect().size
	hide_player()


func _integrate_forces(state: Physics2DDirectBodyState):
	if reset:
		state.transform = Transform2D(0, start_pos)
		speed = Vector2.ZERO
		state.linear_velocity = speed
		reset = false


func force_reset():
	reset = true


func set_power(power: float):
	var fire_power := -2.0 - 6.0 * (power + 1.0)
	ndParticles2DR.process_material.set_param(
		ParticlesMaterial.PARAM_INITIAL_LINEAR_VELOCITY, fire_power
	)
	ndParticles2DL.process_material.set_param(
		ParticlesMaterial.PARAM_INITIAL_LINEAR_VELOCITY, fire_power
	)


func _process(delta: float):
	if not processing:
		return

	var max_speed_delta := max_speed * delta
	var disable_world_speed := false

	if position.x <= 32:
		disable_world_speed = true
		speed.x = pow((position.x / 16) - 3, 2) * max_speed_delta
	elif position.x >= screen_size.x - 32:
		speed.x = -3 * max_speed_delta
	if position.y <= 32:
		speed.y = 3 * max_speed_delta
	elif position.y >= screen_size.y - 32:
		speed.y = -3 * max_speed_delta

	var direction := joystick.get_direction() if Config.has_joystick and joystick else Vector2.ZERO

	if direction == Vector2.ZERO:
		direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)

	if direction.length() > 0:
		direction = direction.normalized()

	speed += direction * 2 * max_speed_delta

	if direction.x == 0:
		if speed.x > world_speed:
			speed.x = (
				speed.x - max_speed_delta
				if max_speed_delta + world_speed < speed.x
				else world_speed
			)
		elif speed.x < world_speed:
			speed.x = (
				speed.x + max_speed_delta
				if max_speed_delta + world_speed > speed.x
				else world_speed
			)

	if direction.y == 0:
		if speed.y > 0:
			speed.y = speed.y - max_speed_delta if max_speed_delta < speed.y else 0.0
		elif speed.y < 0:
			speed.y = speed.y + max_speed_delta if -max_speed_delta > speed.y else 0.0

	if not disable_world_speed and speed.x > world_speed:
		speed.x += world_speed * delta

	speed.x = clamp(speed.x, -max_speed, max_speed)
	speed.y = clamp(speed.y, -max_speed, max_speed)

	linear_velocity = speed

	set_power(direction.x)


func start(pos: Vector2):
	start_pos = pos
	hp = Utils.calc_difficulty_to_hp(Config.difficulty)
	emit_signal("hp_updated", hp)
	force_reset()
	show_player()


func _on_Player_body_entered(_body: Node):
	if immune:
		return
	immune = true
	ndHitSound.random_pitch_play()
	hp -= 1
	emit_signal("hp_updated", hp)
	if hp <= 0:
		die()
		immune = false
	else:
		emit_signal("immune_enabled")


func die():
	ndExplosion.position = position - start_pos
	ndExplosion.play()
	emit_signal("died")
	set_dead()


func set_dead():
	hide_player()
	force_reset()


func show_player():
	ndParticles2DR.emitting = true
	ndParticles2DR.show()
	ndParticles2DL.emitting = true
	ndParticles2DL.show()
	ndCollisionPolygon2D.disabled = false
	processing = true
	ndSprite.show()


func hide_player():
	ndParticles2DR.emitting = false
	ndParticles2DR.hide()
	ndParticles2DL.emitting = false
	ndParticles2DL.hide()
	ndCollisionPolygon2D.set_deferred("disabled", true)
	processing = false
	ndSprite.hide()


func _on_Player_immune_enabled():
	for i in range(3):
		if i > 0:
			yield(get_tree().create_timer(0.1), "timeout")
		ndSprite.modulate = Color(1.7, 0.8, 0.5)
		yield(get_tree().create_timer(0.2), "timeout")
		ndSprite.modulate = Color(1, 1, 1)
	immune = false
