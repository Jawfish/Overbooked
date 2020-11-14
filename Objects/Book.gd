extends RigidBody2D
class_name Book
enum BOOK_COLORS {RED, ORANGE, GREEN, BLUE}

var book_color: int

func _init() -> void:
	book_color = randi() % BOOK_COLORS.size() + 1
	
func _ready() -> void:
	match book_color:
		BOOK_COLORS.RED:
			pass
		BOOK_COLORS.ORANGE:
			pass
		BOOK_COLORS.GREEN:
			pass
		BOOK_COLORS.BLUE:
			pass

