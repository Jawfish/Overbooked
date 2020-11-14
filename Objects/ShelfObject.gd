extends Node2D
class_name ShelfObject


func set_color(color: String) -> void:
	match color.to_lower():
		"red":
			modulate = Color(1, 0, 0)
		"orange":
			modulate = Color(1, 0.5, 0)
		"green":
			modulate = Color(0, 1, 0)
		"blue":
			modulate = Color(0, 0, 1)
