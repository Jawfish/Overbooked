extends Area2D
class_name PlayerBookSuccer

var held_item: Book
var thrown_item: Book
export (float) var throw_speed: float

var _last_direction: Vector2


func _input(event):
	# this is in here because I'm too lazy to hook it up to update properly when the player changes directions
	if _last_direction != get_parent().direction and get_parent().direction != Vector2.ZERO:
		_last_direction = get_parent().direction
	elif _last_direction == null:
		_last_direction = Vector2.RIGHT
	if event.is_action_pressed("interact"):
		if held_item:
			throw_held_item()


func throw_held_item() -> void:
	# can't throw an item if you aren't holding one :WeSmart:
	if not held_item:
		return
	# fix for books ceasing to exist if thrown while in the middle of being picked up
	if (Succ.find_node("Tween") as Tween).is_active():
		return
	var map = get_node("/root/Main")
	map.add_child(held_item)
	var pos: Vector2

	# cheeky way to get the direction the player is facing by checking which interactor is active
	for interactor in get_parent().interactor.get_children():
		if not interactor as Timer and not interactor.disabled:
			pos = interactor.global_position

	# physics and shit
	held_item.global_position = pos
	held_item.rotation = 0
	var force = _last_direction * throw_speed * 10
	(held_item as RigidBody2D).sleeping = false
	(held_item as RigidBody2D).apply_central_impulse(force)

	thrown_item = held_item
	held_item = null

	# if another item exists in the interactor, pick it up after throwing this one
	for body in get_overlapping_bodies():
		if body as Book:
			pick_up_item(body)


func pick_up_item(item_to_pick_up: Book) -> void:
	# if succ tween is active, an item is currently being picked up still
	if (Succ.find_node("Tween") as Tween).is_active():
		return
	if item_to_pick_up == thrown_item:
		return
	Succ.succ(item_to_pick_up, get_parent())
	held_item = item_to_pick_up


func _on_PlayerBookSuccer_body_entered(body: Node) -> void:
	if not held_item:
		pick_up_item(body)


func _on_PlayerBookSuccer_body_exited(body: Node) -> void:
	if body == thrown_item:
		thrown_item = null
