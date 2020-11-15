extends GameObject
class_name DropBoxObject

export (float) var _min_time: float
export (float) var _max_time: float
export (PackedScene) var _book_scene: PackedScene
export (Color) var _red: Color
export (Color) var _orange: Color
export (Color) var _green: Color
export (Color) var _blue: Color
export (int) var _max_books: int
onready var _pip_scene: PackedScene = preload("res://Interface/Pip.tscn")

var _books: Array


func _on_Timer_ready() -> void:
	start_random_timer()


func _on_Timer_timeout() -> void:
	if _books.size() >= _max_books:
		return
	start_random_timer()
	$AudioStreamPlayer2D.play()
	if _books.size() <= 0:
		$AnimationPlayer.play("Exclaim")
	generate_new_book()


func start_random_timer() -> void:
	# randomize so it won't be the same every game
	randomize()
	$Timer.start(rand_range(_min_time, _max_time))


func generate_new_book() -> void:
	var book: Book = _book_scene.instance()
	add_book_pip(book)
	_books.append(book)


# add a visual representation of how many books remain in the dropbox
func add_book_pip(book: Book) -> void:
	var color: Color
	match book.book_color:
		book.BOOK_COLORS.RED:
			color = _red
		book.BOOK_COLORS.ORANGE:
			color = _orange
		book.BOOK_COLORS.GREEN:
			color = _green
		book.BOOK_COLORS.BLUE:
			color = _blue
	var pip = _pip_scene.instance()
	$Pips/GridContainer.add_child(pip)
	pip.modulate = color


func remove_book_pip() -> void:
	pass
