extends Actor
class_name Player

enum STATES {IDLE, MOVING, INTERACTING}

var current_state: int = STATES.IDLE

func _ready() -> void:
	Globals.player = self

func _physics_process(delta):
	# get input action strength
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# normalize it
	direction = direction.normalized()
	
	# emit current player state as a signal so other things can know
	# these are defined in the parent (Actor) class
	if direction != Vector2.ZERO:
		_on_direction_changed(direction)
		if not current_state == STATES.MOVING:		
			current_state = STATES.MOVING
			emit_signal("moving")
	elif direction == Vector2.ZERO:
		if not current_state == STATES.IDLE:
			current_state = STATES.IDLE
			emit_signal("idle")

	# move
	# TODO: acceleration and deceleration
	var movement = movement_speed * direction
	# uses delta time automatically
	move_and_slide(movement)


func _on_direction_changed(input_dir: Vector2):
	# update active interactor shapes based on input direction
	var dirs = {
		Vector2(-1, 0): $Interactor/Left,
		Vector2(1, 0): $Interactor/Right,
		Vector2(0, -1): $Interactor/Up,
		Vector2(0, 1): $Interactor/Down
	}
	for dir in dirs:
		var active = (abs(input_dir.angle_to(dir)) <= deg2rad(45.00001))
		#print(str(dir) + ": " + str(abs(rad2deg(input_dir.angle_to(dir)))) + " " + str(active))
		dirs[dir].disabled = !active
