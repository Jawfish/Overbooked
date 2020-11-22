extends Node2D

var game_over: PackedScene = preload("res://Interface/GameOver.tscn")

var prev_val: float = 11


func _ready() -> void:
	Globals.connect("wrong_shelf", self, "penalty")
	Globals.connect("dropbox_full", self, "penalty")
	Globals.connect("score_increased", self, "bonus")


func _on_LevelTimer_timeout() -> void:
	get_tree().change_scene_to(game_over)


func _on_ProgressBar_value_changed(value: float) -> void:
	if floor(value) < prev_val:
		prev_val = floor(value)
		if not Globals.mute_sfx:
			$AudioStreamPlayer.play()
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Low Time")

func penalty() -> void:
	var time_left = $MainCanvas/LevelTimer.time_left - 5
	if time_left > 0:
		$MainCanvas/LevelTimer.stop()
		$MainCanvas/LevelTimer.wait_time = time_left
		$MainCanvas/LevelTimer.start()
		$AnimationPlayer.play("Penalty")
	else:
		get_tree().change_scene_to(game_over)

func bonus() -> void:
	var time_left = $MainCanvas/LevelTimer.time_left + 3
	$MainCanvas/LevelTimer.stop()
	$MainCanvas/LevelTimer.wait_time = time_left
	$MainCanvas/LevelTimer.start()
	$AnimationPlayer.play("Bonus")
	
