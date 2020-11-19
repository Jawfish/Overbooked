extends Node

signal colorblind_toggled

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


func _ready() -> void:
	if colorblind:
		toggle_colorblind_mode()


func toggle_colorblind_mode() -> void:
	red = colorblind_red
	orange = colorblind_orange
	green = colorblind_green
	blue = colorblind_blue
	emit_signal("colorblind_toggled")
