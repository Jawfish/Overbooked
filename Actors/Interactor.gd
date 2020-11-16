extends Area2D
class_name Interactor

export var highlightMaterial: Material

var TILE_SIZE: float = 64.0
var actor: Actor
var held_item: Book
var target: PhysicsBody2D
var thrown_item: Book


func _enter_tree() -> void:
	actor = get_parent()


func _input(event):
	if event.is_action_pressed("interact"):
		if held_item:
			drop_held_item()


func drop_held_item() -> void:
	var map = get_node("/root/Main")
	map.add_child(held_item)
	var pos: Vector2
	# cheeky way to get the direction the player is facing by checking which interactor is active
	for interactor in get_children():
		if not interactor as Timer and not interactor.disabled:
			pos = interactor.global_position
	held_item.global_position = pos
	held_item.rotation = 0
	# the center of the player; actor.global_position doesn't work due to offsets relative to the interactor
	var center = find_node("Center").global_position
	var vel = held_item.transform.basis_xform(pos - find_node("Center").global_position) * 25
	var force = vel - held_item.linear_velocity
	(held_item as RigidBody2D).sleeping = false
	(held_item as RigidBody2D).apply_central_impulse(force)
	thrown_item = held_item
	held_item = null


func pick_up_item(item_to_pick_up: Book) -> void:
	if item_to_pick_up == thrown_item:
		return
	Succ.succ(item_to_pick_up, actor)
	held_item = target
	target = null


func _on_body_entered(body: PhysicsBody2D):
	#highlight_object(body)
#	print(body.name + " entered interactor")
	target = body
	if not held_item and target as Book:
		pick_up_item(target)


func _on_body_exited(body: PhysicsBody2D):
	#unhighlight_object(body)
#	print(body.name + " left interactor")
	if body == thrown_item:
		thrown_item = null
	if get_overlapping_bodies().size() == 0:
		target = null
	else:
		for body in get_overlapping_bodies():
			if body as Book:
				target = body


func find_target() -> Book:
	for body in get_overlapping_bodies():
		if body as Book:
			return body
	return null


# these don't quite work yet
func highlight_object(node: Node2D):
	# find sprites
	var sprites = [node.get_node_or_null("Sprite") as Sprite]

	# clone and add effects
	for sprite in sprites:
		if sprite.get_node_or_null("HighlightEffect") != null:
			continue
		print("clone")
		var clone: Sprite = sprite.duplicate()
		clone.name = "HighlightEffect"
		clone.material = highlightMaterial
		clone.owner = self
		sprite.add_child(clone)


func unhighlight_object(node: PhysicsBody2D):
	var sprites = [node.get_node_or_null("Sprite") as Sprite]
	for sprite in sprites:
		var highlight = sprite.get_node_or_null("HighlightEffect") as Node
		if highlight:
			print("delete")
			highlight.queue_free()
