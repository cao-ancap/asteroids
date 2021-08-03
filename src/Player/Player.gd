extends RigidBody2D

signal died
signal hp_updated(hp)

var joystick: Node2D

export var max_speed := 450.0
export var world_speed := 0.0
export var base_hp := 10

var hp: int

var screen_size: Vector2
var speed := Vector2.ZERO
var start_pos := Vector2.ZERO

var reset := false
var processing := false


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

	var direction := Vector2.ZERO
	if joystick:
		direction = joystick.get_direction()
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
	if Input.is_action_pressed("move_up"):
		direction.y = -1

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

	speed.x = [[-max_speed, speed.x].max(), max_speed].min()
	speed.y = [[-max_speed, speed.y].max(), max_speed].min()

	linear_velocity = speed


func start(pos: Vector2):
	start_pos = pos
	hp = base_hp
	emit_signal("hp_updated", hp)
	force_reset()
	show_player()


func _on_Player_body_entered(_body: Node):
	$HitSound.random_pitch_play()
	hp -= 1
	emit_signal("hp_updated", hp)
	if hp <= 0:
		die()


func die():
	$Explosion.position = position - start_pos
	$Explosion.play()
	emit_signal("died")
	hide_player()
	force_reset()


func show_player():
	$Particles2DR.emitting = true
	$Particles2DR.show()
	$Particles2DL.emitting = true
	$Particles2DL.show()
	$CollisionPolygon2D.disabled = false
	processing = true
	$Sprite.show()


func hide_player():
	$Particles2DR.emitting = false
	$Particles2DR.hide()
	$Particles2DL.emitting = false
	$Particles2DL.hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	processing = false
	$Sprite.hide()
