extends Area2D
class_name Interactor

export (Color) var highlight: Color

var target: PhysicsBody2D


# interact with target
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		pass


func _on_body_entered(body: PhysicsBody2D):
	print(body.name + " entered")
	if target:
		unhighlight_object(target)
	highlight_object(body)
	target = body


func _on_body_exited(body: PhysicsBody2D):
	print(body.name + " exited")
	if body == target:
		unhighlight_object(target)
		target = null


func highlight_object(node: Node2D):
	print(node.name + " highlighted")
	if node == null:
		return
	node.modulate = node.modulate + highlight


func unhighlight_object(node: Node2D):
	print(node.name + " unhighlighted")
	if node == null:
		return
	node.modulate = node.modulate - highlight
