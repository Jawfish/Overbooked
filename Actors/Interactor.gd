extends Area2D
class_name Interactor

export (Color) var highlight: Color

var target: PhysicsBody2D


# interact with target; uses _unhandled_input so as not to interfere with book tossing
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		# if cart is close enough and shelf is same color as top book of cart, unload top book
		if (
			target
			and (Globals.player.global_position - Globals.cart.global_position).length() < 100
		):
			if (
				target.shelf_color.to_lower()
				== Globals.cart._books[Globals.cart._books.size() - 1].book_color.to_lower()
			):
				var shelved_book = Globals.cart.get_top_book()


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
