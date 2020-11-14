extends GameObject
class_name ShelfObject

enum SHELF_COLORS {RED, ORANGE, GREEN, BLUE}

var shelf_color: int

func set_color(color: String) -> void:
	match color.to_lower():
		"red":
			modulate = Color(1.0, 0.5, 0.5, 1.0) 
			shelf_color = SHELF_COLORS.RED
		"orange":
			modulate = Color(1.0, 0.8, 0.5, 1.0)
			shelf_color = SHELF_COLORS.ORANGE
		"green":
			modulate = Color(0.5, 1.0, 0.5, 1.0)
			shelf_color = SHELF_COLORS.GREEN
		"blue":
			modulate = Color(0.5, 0.5, 1.0, 1.0)
			shelf_color = SHELF_COLORS.BLUE
	name = color.capitalize() + "ShelfObject"
	print(name)
