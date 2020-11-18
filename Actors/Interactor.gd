extends Area2D
class_name Interactor

export (Color) var highlight: Color

var actor: Actor
var target: PhysicsBody2D
var highlighted_object: Node


func _enter_tree() -> void:
	actor = get_parent()


func _on_body_entered(body: PhysicsBody2D):
	if target:
		return
	if "Shelf" in body.get_parent().name:
		highlight_object(body.get_parent())
	elif "Cart" in body.name:
		highlight_object(body)
	target = body


func _on_body_exited(body: PhysicsBody2D):
	if "Shelf" in body.get_parent().name:
		unhighlight_object(body.get_parent())
	elif "Cart" in body.name:
		unhighlight_object(body)
	if get_overlapping_bodies().size() == 0:
		target = null


func find_target() -> Book:
	for body in get_overlapping_bodies():
		if body as Book:
			return body
	return null


func highlight_object(node: Node2D):
	if highlighted_object:
		return
	highlighted_object = node
	node.modulate = node.modulate + highlight


func unhighlight_object(node: Node2D):
	if not highlighted_object:
		return
	highlighted_object = null
	node.modulate = node.modulate - highlight
