extends Node2D

var actor: Actor

onready var scale_x = scale.x

var idle: bool = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if idle:
			$AnimationTree.set("parameters/dle_interact/active", true)
		else:
			$AnimationTree.set("parameters/walk_interact/active", true)


func _enter_tree() -> void:
	actor = get_parent()
	actor.connect("moving", self, "play_walking_animation")
	actor.connect("idle", self, "play_idle_animation")


func _physics_process(delta: float) -> void:
	# orient the sprites the correct direction
	# if actor.direction.x is 0, don't change anything so the previous orientation is retained
	if actor.direction.x < 0:
		scale.x = -scale_x
	elif actor.direction.x > 0:
		scale.x = scale_x


func play_walking_animation() -> void:
	$AnimationTree.set("parameters/blend/blend_amount", 0)
	idle = false


func play_idle_animation() -> void:
	$AnimationTree.set("parameters/blend/blend_amount", 1)
	idle = true
