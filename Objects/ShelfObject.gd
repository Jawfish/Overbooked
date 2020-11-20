extends GameObject
class_name ShelfObject

export var shelf_color: String


func _ready() -> void:
	Globals.connect("colorblind_toggled", self, "color_shelf", [shelf_color])


# uses a string instead of a Color to make colorblind toggling easier
func color_shelf(color: String) -> void:
	shelf_color = color
	match shelf_color.to_lower():
		"red":
			modulate = Globals.red
		"orange":
			modulate = Globals.orange
		"green":
			modulate = Globals.green
		"blue":
			modulate = Globals.blue
	name = color.capitalize() + "ShelfObject"
