extends RigidBody2D
class_name Book
enum BOOK_COLORS { RED, ORANGE, GREEN, BLUE }

var book_color: int


func _init() -> void:
	randomize()
	book_color = randi() % BOOK_COLORS.size()


func _ready() -> void:
	match book_color:
		BOOK_COLORS.RED:
			modulate = Color.red
		BOOK_COLORS.ORANGE:
			modulate = Color.orange
		BOOK_COLORS.GREEN:
			modulate = Color.green
		BOOK_COLORS.BLUE:
			modulate = Color.blue
