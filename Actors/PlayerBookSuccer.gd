extends Area2D
class_name PlayerBookSuccer
signal succ

var held_item: Book
var thrown_item: Book
export (float) var throw_speed: float

var _last_direction: Vector2


# throw book; uses _unhandled_input so as not to interfere with shelving
func _unhandled_input(event):
	# this is in here because I'm too lazy to hook it up to update properly when the player changes directions
	if _last_direction != get_parent().direction and get_parent().direction != Vector2.ZERO:
		_last_direction = get_parent().direction
	elif _last_direction == null:
		_last_direction = Vector2.RIGHT
	if event.is_action_pressed("interact"):
		if held_item and not Globals.player_is_targetting:
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

	# physics and shit
	held_item.global_position = global_position
	held_item.rotation = 0
	var force = _last_direction.normalized() * throw_speed * 10
	(held_item as RigidBody2D).sleeping = false
	(held_item as RigidBody2D).apply_central_impulse(force)

	thrown_item = held_item
	held_item = null
	get_parent().find_node("Book").visible = false

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
	yield(Succ.find_node("Tween"), "tween_completed")
	emit_signal("succ")
	get_parent().find_node("Book").visible = true


func _on_PlayerBookSuccer_body_entered(body: Node) -> void:
	if not held_item:
		# make it so the player can only pick up unscanned books
		if body as Book and not body.book_color:
			pick_up_item(body)


func _on_PlayerBookSuccer_body_exited(body: Node) -> void:
	if body == thrown_item:
		thrown_item = null
