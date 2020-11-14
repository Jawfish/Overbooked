extends Area2D

export var highlightMaterial: Material

var TILE_SIZE: float = 64.0
var actor: Actor
var heldItem: Node2D
var target: PhysicsBody2D

func _enter_tree() -> void:
	actor = get_parent()

func _input(event):
	if event.is_action_pressed("ui_select"):
		if heldItem and not target:
			# drop
			var map = get_node("/root/Main")
			map.add_child(heldItem)
			
			var pos: Vector2 = actor.global_position + Vector2(64, 0)
			# round pos to tile pos
			pos = Vector2(round((pos.x - TILE_SIZE / 2) / TILE_SIZE) * TILE_SIZE,
						  round((pos.y - TILE_SIZE / 2) / TILE_SIZE) * TILE_SIZE)
			# offset to center
			pos += Vector2(TILE_SIZE / 2, TILE_SIZE / 2)
			
			heldItem.global_position = pos
			heldItem.rotation = 0
			(heldItem as RigidBody2D).sleeping = false
			(heldItem as RigidBody2D).velocity = Vector2.ZERO
			heldItem = null
		elif not heldItem and target:
			# pick up
			target.get_parent().remove_child(target)  # unlink from scene tree
			heldItem = target
			target = null
		elif heldItem and target:
			pass  # swap?

func _on_body_entered(body: PhysicsBody2D):
	#highlight_object(body)
	#print("body in interactor")
	target = body

func _on_body_exited(body: PhysicsBody2D):
	#unhighlight_object(body)
	#print("body left")
	var still_overlapping = self.get_overlapping_bodies()
	target = still_overlapping[0] if len(still_overlapping) > 0 else null


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
