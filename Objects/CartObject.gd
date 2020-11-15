extends KinematicBody2D
class_name CartObject

export (int) var _max_books: int = 3
export (int) var _push_speed: int = 1

var _books: Array = []
var _attached: bool = false

onready var _player: Actor = Globals.player


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_cart"):
		if (_player.position - position).length() < 100:
			attach_to_player()
	if event.is_action_released("move_cart") and _attached:
		_attached = false


func _physics_process(delta: float) -> void:
	rotation = 0
	if _attached and _player:
		move_and_slide((_player.position - position) * 2)


func push(direction: Vector2) -> void:
	move_and_collide(direction * _push_speed)


func add_book(book: StaticBody2D) -> void:
	if _books.size() < _max_books:
		_books.append(book)


func get_top_book() -> StaticBody2D:
	return _books.pop_back()


func attach_to_player() -> void:
	_attached = true


func detach_from_player() -> void:
	_attached = false
