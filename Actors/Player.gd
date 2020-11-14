extends Actor
class_name Player


func _physics_process(delta):
	# get input action strength
	var direction: Vector2
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# normalize it
	direction = direction.normalized()

	# move
	# TODO: acceleration and deceleration
	var movement = movement_speed * direction * delta
	move_and_collide(movement)
