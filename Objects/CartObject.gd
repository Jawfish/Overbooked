extends KinematicBody2D
class_name CartObject

export (int) var _max_books: int = 3
export (int) var _push_speed: int = 1
export (float, 0.5, 1.5) var _pitch_min: float
export (float, 0.5, 1.5) var _pitch_max: float
var _books: Array = []
var _attached: bool = false

onready var _player: Actor = Globals.player


func _ready() -> void:
	Globals.cart = self
	$TextureProgress.max_value = _max_books
	update_progress_bar_value()


func _physics_process(delta: float) -> void:
	rotation = 0
	if _attached and _player:
		move_and_slide((_player.position - position) * 3)
	# fix for books not entering cart if scanned while within the BookReceptionArea
	for body in $BookReceptionArea.get_overlapping_bodies():
		if body as Book:
			_on_BookReceptionArea_body_entered(body)
	if Input.is_action_pressed("move_cart"):
		if (_player.position - position).length() < 100:
			attach_to_player()
	if Input.is_action_just_released("move_cart") and _attached:
		_attached = false


func push(direction: Vector2) -> void:
	move_and_collide(direction * _push_speed)


func add_book(book: RigidBody2D) -> void:
	if _books.size() < _max_books:
		_books.append(book)
	update_progress_bar_value()


func update_book_color() -> void:
	if _books.size() > 0:
		$TopBookDisplay.modulate = _books[_books.size() - 1].modulate


func get_top_book() -> RigidBody2D:
	var i = randf()
	if i < 0.33:
		if not Globals.mute_sfx:
			$BookPlace1.play()
	elif i < 0.66:
		if not Globals.mute_sfx:		
			$BookPlace2.play()
	else:
		if not Globals.mute_sfx:		
			$BookPlace3.play()
	var book_to_return = _books.pop_back()
	update_progress_bar_value()
	return book_to_return


func check_top_book_color() -> Color:
	var c = Color.white
	if _books:
		c = _books[_books.size() - 1].modulate
	return c


func update_progress_bar_value() -> void:
	$TextureProgress.value = _books.size()
	if $TextureProgress.value == 0:
		$TextureProgress.visible = false
		$TopBookDisplay.visible = false
	else:
		$TextureProgress.visible = true
		$TopBookDisplay.visible = true
	update_book_color()


func attach_to_player() -> void:
	_attached = true


func detach_from_player() -> void:
	_attached = false


func _on_BookReceptionArea_body_entered(body: Node) -> void:
	if body as Book and _books.size() < _max_books and (body as Book).book_color != "":
		(body as RigidBody2D).collision_layer = 0
		(body as RigidBody2D).sleeping = true
		body.linear_velocity = Vector2.ZERO
		Succ.succ(body, self)
		$AnimationPlayer.play("Succ")
		add_book(body)
