extends Particles2D


func start(world_speed):
	process_material.set("initial_velocity", world_speed)
	emitting = true


func stop():
	emitting = false
