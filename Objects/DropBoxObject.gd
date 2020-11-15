extends GameObject
class_name DropBoxObject

export(float) var min_time: float
export(float) var max_time: float
export(PackedScene) var book_scene: PackedScene
var _books: Array


func _on_Timer_ready() -> void:
	start_random_timer()

func _on_Timer_timeout() -> void:
	start_random_timer()
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Exclaim")
	generate_new_book()
	
func start_random_timer() -> void:
	# randomize so it won't be the same every game
	randomize()
	$Timer.start(rand_range(min_time, max_time))

func generate_new_book() -> void:
	var book: Book = book_scene.instance()
	add_book_pip(book)
	_books.append(book)
	
# add a visual representation of how many books remain in the dropbox
func add_book_pip(book: Book) -> void:
	var pip = Rect2(position + Vector2(0, 32), Vector2.ONE * 10)
	var color: Color
	match book.book_color:
		book.BOOK_COLORS.RED:
			color = Color.blue
		book.BOOK_COLORS.ORANGE:
			color = Color.orange
		book.BOOK_COLORS.GREEN:
			color = Color.green
		book.BOOK_COLORS.BLUE:
			color = Color.blue
	draw_rect(pip, color)

func remove_book_pip() -> void:
	pass
