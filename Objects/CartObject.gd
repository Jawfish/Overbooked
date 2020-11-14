extends KinematicBody2D
class_name CartObject

export(int) var _max_books: int = 3
export(int) var _push_speed: int = 1

var _books: Array = []
var _being_pushed_by_player: bool = false

onready var _player: Actor = get_parent().find_node("Player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		attach_to_player()

func _physics_process(delta: float) -> void:
	rotation = 0
	if _being_pushed_by_player:
		move_and_slide((_player.position - position) * 2)

func push(direction: Vector2) -> void:
	move_and_collide(direction * _push_speed)

# TODO: replace Object with book type
func add_book(book: Object):
	if _books.size() < _max_books:
		_books.append(book)

# TODO: replace Object with book type
func get_top_book() -> Object:
	return _books.pop_back()

func attach_to_player() -> void:
	_being_pushed_by_player = true

func detach_from_player() -> void:
	_being_pushed_by_player = false
