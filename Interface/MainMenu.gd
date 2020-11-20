extends Control

var game: PackedScene = preload("../Engine/Main.tscn")


func _on_Start_pressed() -> void:
	get_tree().change_scene_to(game)


func _on_ColorblindToggle_toggled(pressed: bool) -> void:
	Globals.colorblind = pressed
	Globals.toggle_colorblind_mode()
	print(Globals.colorblind)
