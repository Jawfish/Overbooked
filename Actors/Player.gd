extends Actor
class_name Player

enum STATES {IDLE, MOVING, INTERACTING}

var current_state: int = STATES.IDLE

func _physics_process(delta):
	# get input action strength
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# normalize it
	direction = direction.normalized()
	
	# emit current player state as a signal so other things can know
	# these are defined in the parent (Actor) class
	if direction != Vector2.ZERO:
		if not current_state == STATES.MOVING:		
			current_state = STATES.MOVING
			emit_signal("moving")
	elif direction == Vector2.ZERO:
		if not current_state == STATES.IDLE:
			current_state = STATES.IDLE
			emit_signal("idle")
	
	# move
	# TODO: acceleration and deceleration
	var movement = movement_speed * direction * delta
	move_and_collide(movement)
