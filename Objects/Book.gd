extends RigidBody2D
class_name Book

var book_color: String

func _init() -> void:
	Globals.connect("colorblind_toggled", self, "color_book", [book_color])

func _enter_tree() -> void:
	# the scale is animated to 0 when picked up, 
	# so set it back to 1 when placed back in the world
	scale = Vector2.ONE


# uses a string instead of a Color to make colorblind toggling easier
func color_book(color: String) -> void:
	book_color = color
	match book_color.to_lower():
		"red":
			modulate = Globals.red
		"orange":
			modulate = Globals.orange
		"green":
			modulate = Globals.green
		"blue":
			modulate = Globals.blue
