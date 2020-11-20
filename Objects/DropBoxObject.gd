extends GameObject
class_name DropBoxObject

export (float) var _min_time: float
export (float) var _max_time: float
export (PackedScene) var _book_scene: PackedScene
export (int) var _max_books: int

var _last_book
var _books: Array
var map: TileMap

onready var progress: ProgressBar = $ProgressBar


func _ready() -> void:
	# remove areas that are not on floors
	for area in $Area2D.get_children():
		var location_to_check: Vector2 = area.global_position
		var map_coordinates: Vector2 = map.world_to_map(location_to_check)
		var tile_index: int = map.get_cellv(map_coordinates)
		var tile_name: String = map.tile_set.tile_get_name(tile_index)
		if not tile_name == "FloorTile":
			area.queue_free()
	update_progress()


func _on_Timer_ready() -> void:
	start_random_timer()


func _on_Timer_timeout() -> void:
	if _books.size() >= _max_books:
		return
	start_random_timer()
	if not Globals.mute_sfx:
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
	_books.append(book)
	# make sure Player picks up Book if they are already within the Area2D when new Book is generated
	for body in $Area2D.get_overlapping_bodies():
		if body as Player:
			_on_Area2D_body_entered(body)
	update_progress()


func update_progress() -> void:
	progress.max_value = _max_books
	progress.value = _books.size()
	if progress.value == progress.max_value:
		$ProgressBarAnimation.play("Flash")
	else:
		$ProgressBarAnimation.stop()
		$ProgressBar.modulate = Color.white


func _on_Area2D_body_entered(body: Node) -> void:
	if not body as Player:
		return
	if ((body as Player).succer as PlayerBookSuccer).held_item == null and _books:
		((body as Player).succer as PlayerBookSuccer).held_item = _books.pop_back()
		Succ.succ(null, self)
		((body as Player).find_node("SuccPlayer") as AnimationPlayer).play("Succ")
		body.find_node("Book").visible = true
	if not _books and $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Unexclaim")
	update_progress()
