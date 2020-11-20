extends Label


func _process(delta: float) -> void:
	format_score(Globals.score)


func format_score(score: int) -> void:
	text = "Score: " + str(score)
