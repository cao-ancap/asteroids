extends RigidBody2D

signal dead

export var max_speed = 450
export var world_speed = 0
var screen_size

var speed = Vector2.ZERO
var start_pos = Vector2.ZERO

var reset = false

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _integrate_forces(state):
	if reset:
		state.transform = Transform2D(0, start_pos)
		state.linear_velocity = Vector2.ZERO
		reset = false
		
func force_reset():
	reset = true

func _process(delta):
	var max_speed_delta = max_speed * delta
	var disable_world_speed = false
	if position.x <= 32:
		disable_world_speed = true
		speed.x = pow(((position.x / 16) - 3), 2) * max_speed_delta
	elif position.x >= screen_size.x - 32:
		speed.x = -3 * max_speed_delta
	if position.y <= 32:
		speed.y = 3 * max_speed_delta
	elif position.y >= screen_size.y - 32:
		speed.y = -3 * max_speed_delta
		
	var direction = Vector2.ZERO
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
			speed.x -= max_speed_delta
		elif speed.x < world_speed:
			speed.x += max_speed_delta
		speed.x = stepify(speed.x, 0.01)
	if direction.y == 0:
		if speed.y > 0:
			speed.y -= max_speed_delta
		elif speed.y < 0:
			speed.y += max_speed_delta
		speed.y = stepify(speed.y, 0.01)
	if not disable_world_speed and speed.x > world_speed:
		speed.x += world_speed * delta
	
	speed.x = [[-max_speed, speed.x].max(), max_speed].min()
	speed.y = [[-max_speed, speed.y].max(), max_speed].min()
	
	linear_velocity = speed

func start(pos):
	start_pos = pos
	force_reset()
	show()
	$CollisionPolygon2D.disabled = false

func _on_Player_body_entered(_body):
	hide()
	emit_signal("dead")
	force_reset()
	$CollisionPolygon2D.set_deferred("disabled", true)
