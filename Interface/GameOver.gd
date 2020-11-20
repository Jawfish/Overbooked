extends Control

var main_menu: PackedScene = load("res://Interface/MainMenu.tscn")


func _ready() -> void:
	$CenterContainer/Score.text = "You scored " + str(Globals.score)


func _on_MainMenu_pressed() -> void:
	Globals.score = 0
	get_tree().change_scene_to(main_menu)
	(Globals.find_node("Click") as AudioStreamPlayer).play()



func _on_MainMenu_mouse_entered() -> void:
	(Globals.find_node("Hover") as AudioStreamPlayer).play()
