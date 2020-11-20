extends Node2D

var game_over: PackedScene = preload("res://Interface/GameOver.tscn")

var prev_val: float = 11


func _ready() -> void:
	pass


func _on_LevelTimer_timeout() -> void:
	get_tree().change_scene_to(game_over)


func _on_ProgressBar_value_changed(value: float) -> void:
	if floor(value) < prev_val:
		prev_val = floor(value)
		$AudioStreamPlayer.play()
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Low Time")
