extends Control

var game: PackedScene = preload("../Engine/Main.tscn")
#
func _ready() -> void:
	for shelf in $ColorblindExamples.get_children():
		(shelf as ShelfObject).color_shelf((shelf as ShelfObject).shelf_color)

func _on_Start_pressed() -> void:
	get_tree().change_scene_to(game)
	(Globals.find_node("Click") as AudioStreamPlayer).play()	

		
func _on_Start_mouse_entered() -> void:
	(Globals.find_node("Hover") as AudioStreamPlayer).play()


func _on_ColorblindToggle_mouse_entered() -> void:
	(Globals.find_node("Hover") as AudioStreamPlayer).play()


func _on_ColorblindToggle_pressed() -> void:
	Globals.toggle_colorblind_mode()
	(Globals.find_node("Click") as AudioStreamPlayer).play()	
