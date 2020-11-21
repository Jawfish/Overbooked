extends Control

# this is really stupid and I should have made a base button scene but too late now

var game: PackedScene = preload("../Engine/Main.tscn")
var instructions: PackedScene = preload("res://Interface/Instructions.tscn")
var credits: PackedScene = preload("res://Interface/Credits.tscn")


func _ready() -> void:
	for shelf in $ColorblindExamples.get_children():
		(shelf as ShelfObject).color_shelf((shelf as ShelfObject).shelf_color)

func _on_Start_pressed() -> void:
	get_tree().change_scene_to(game)
	if not Globals.mute_sfx:	
		(Globals.find_node("Click") as AudioStreamPlayer).play()	

		
func _on_Start_mouse_entered() -> void:
	if not Globals.mute_sfx:
		(Globals.find_node("Hover") as AudioStreamPlayer).play()


func _on_ColorblindToggle_mouse_entered() -> void:
	if not Globals.mute_sfx:
		(Globals.find_node("Hover") as AudioStreamPlayer).play()


func _on_ColorblindToggle_pressed() -> void:
	Globals.toggle_colorblind_mode()
	if not Globals.mute_sfx:	
		(Globals.find_node("Click") as AudioStreamPlayer).play()	


func _on_Instructions_pressed() -> void:
	get_tree().change_scene_to(instructions)
	if not Globals.mute_sfx:	
		(Globals.find_node("Click") as AudioStreamPlayer).play()	


func _on_Credits_pressed() -> void:
	get_tree().change_scene_to(credits)
	if not Globals.mute_sfx:	
		(Globals.find_node("Click") as AudioStreamPlayer).play()	


func _on_Instructions_mouse_entered() -> void:
	if not Globals.mute_sfx:
		(Globals.find_node("Hover") as AudioStreamPlayer).play()


func _on_Credits_mouse_entered() -> void:
	if not Globals.mute_sfx:
		(Globals.find_node("Hover") as AudioStreamPlayer).play()


