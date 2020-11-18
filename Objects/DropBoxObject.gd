extends GameObject
class_name DropBoxObject

export (float) var _min_time: float
export (float) var _max_time: float
export (PackedScene) var _book_scene: PackedScene
export (int) var _max_books: int

onready var _pip_scene: PackedScene = preload("res://Interface/Pip.tscn")

var _last_book
var _books: Array
var map: TileMap


func _ready() -> void:
	# remove areas that are not on floors
	for area in $Area2D.get_children():
		var location_to_check: Vector2 = area.global_position
		var map_coordinates: Vector2 = map.world_to_map(area.global_position)
		var tile_index: int = map.get_cellv(map_coordinates)
		var tile_name: String = map.tile_set.tile_get_name(tile_index)
		if not tile_name == "FloorTile":
			area.queue_free()


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
	# make sure Player picks up Book if they are already within the Area2D when new Book is generated
	for body in $Area2D.get_overlapping_bodies():
		if body as Player:
			_on_Area2D_body_entered(body)


# add a visual representation of how many books remain in the dropbox
func add_book_pip(book: Book) -> void:
	var pip = _pip_scene.instance()
	$Pips/GridContainer.add_child(pip)
	_last_book = pip


func remove_last_book_pip() -> void:
	if _last_book:
		$Pips/GridContainer.remove_child(_last_book)
		_last_book.queue_free()
		_last_book = $Pips/GridContainer.get_children().pop_back()


func _on_Area2D_body_entered(body: Node) -> void:
	if not body as Player:
		return
	if ((body as Player).succer as PlayerBookSuccer).held_item == null and _books:
		remove_last_book_pip()
		((body as Player).succer as PlayerBookSuccer).held_item = _books.pop_back()
		Succ.succ(null, self)
		((body as Player).find_node("SuccPlayer") as AnimationPlayer).play("Succ")
	if not _books and $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Unexclaim")
