extends ProgressBar


func _process(delta: float) -> void:
	var time_left = (get_parent().get_parent().find_node("LevelTimer") as Timer).time_left
	format_progress(time_left)
	value = time_left


func _ready() -> void:
	format_progress(0)


func format_progress(time: int) -> void:
	get_child(0).text = "Remaining Time: " + str(time)
