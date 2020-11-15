extends Node2D

export (Texture) var head_texture: Texture = preload("res://Assets/Characters/Monkey/Head01.png")
export (Texture) var body_texture: Texture = preload("res://Assets/Characters/Monkey/Torso.png")
export (Texture) var left_hand_texture: Texture = preload("res://Assets/Characters/Monkey/HandL.png")
export (Texture) var right_hand_texture: Texture = preload("res://Assets/Characters/Monkey/HandR.png")
export (Texture) var leg_texture: Texture = preload("res://Assets/Characters/Monkey/Leg.png")

var actor: Actor

onready var scale_x = scale.x


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		$AnimationTree.set("parameters/interact/active", true)


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


func _ready() -> void:
	$BodyParts/Head/HeadSprite.texture = head_texture
	$BodyParts/Body/BodySprite.texture = body_texture
	$BodyParts/LeftLeg/LeftLegSprite.texture = leg_texture
	$BodyParts/RightLeg/RightLegSprite.texture = leg_texture
	$BodyParts/LeftHand/LeftHandSprite.texture = left_hand_texture
	$BodyParts/RightHand/RightHandSprite.texture = right_hand_texture


func play_walking_animation() -> void:
	$AnimationPlayer.play("Walk")
	$AnimationPlayer.playback_speed = 2


func play_idle_animation() -> void:
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.playback_speed = 1
