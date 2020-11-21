extends Node

signal colorblind_toggled
signal wrong_shelf
signal dropbox_full

export (Color) var red: Color
export (Color) var orange: Color
export (Color) var green: Color
export (Color) var blue: Color
export (Color) var colorblind_red: Color
export (Color) var colorblind_orange: Color
export (Color) var colorblind_green: Color
export (Color) var colorblind_blue: Color
var colorblind: bool = false
var player: Player
var cart: CartObject
var player_is_targetting: bool = false
var score: int = 0
var mute_sfx: bool = false
var main = preload("res://Interface/MainMenu.tscn")
func _ready() -> void:
	$Tween.interpolate_property($AudioStreamPlayer, "volume_db", -50, -15, 3, Tween.TRANS_LINEAR)
	$Tween.start()

func toggle_colorblind_mode() -> void:
	var r = red
	var o = orange
	var g = green
	var b = blue
	red = colorblind_red
	colorblind_red = r	
	orange = colorblind_orange
	colorblind_orange = o
	green = colorblind_green
	colorblind_green = g
	blue = colorblind_blue
	colorblind_blue = b
	emit_signal("colorblind_toggled")


func _on_MuteMusic_toggled(button_pressed: bool) -> void:
	$AudioStreamPlayer.playing = !button_pressed


func _on_MuteSfx_toggled(button_pressed: bool) -> void:
	mute_sfx = button_pressed
