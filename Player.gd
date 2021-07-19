extends RigidBody2D

signal hit

export var max_speed = 450
export var world_speed = 0
var screen_size

var speed = Vector2.ZERO;

func _ready():
	screen_size = get_viewport_rect().size
	#hide()


func _process(delta):
	var disable_world_speed = false
	if position.x <= 32:
		speed.x = 2 * max_speed * delta
		disable_world_speed = true
	elif position.x >= screen_size.x - 32:
		speed.x = -2 * max_speed * delta
	if position.y <= 32:
		speed.y = 2 * max_speed * delta
	elif position.y >= screen_size.y - 32:
		speed.y = -2 * max_speed * delta
		
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
		
	speed += direction * max_speed * delta
	
	if direction.x == 0:
		if speed.x > world_speed:
			speed.x -= max_speed * delta
			if not disable_world_speed:
				speed.x += world_speed * delta
		elif speed.x < world_speed:
			speed.x += max_speed * delta
	if direction.y == 0:
		if speed.y > 0:
			speed.y -= max_speed * delta
		elif speed.y < 0:
			speed.y += max_speed * delta
	
	speed.x = [[-max_speed, speed.x].max(), max_speed].min()
	speed.y = [[-max_speed, speed.y].max(), max_speed].min()
	
	linear_velocity = speed

func start(pos):
	position = pos
	show()
	$CollisionPolygon2D.disabled = false


func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionPolygon2D.set_deferred("disabled", true)
