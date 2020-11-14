extends Node2D

export (Texture) var head_texture: Texture = preload("res://Assets/Characters/Monkey/Head01.png")
export (Texture) var body_texture: Texture = preload("res://Assets/Characters/Monkey/Torso.png")
export (Texture) var left_hand_texture: Texture = preload("res://Assets/Characters/Monkey/HandL.png")
export (Texture) var right_hand_texture: Texture = preload("res://Assets/Characters/Monkey/HandR.png")
export (Texture) var leg_texture: Texture = preload("res://Assets/Characters/Monkey/Leg.png")


func _ready() -> void:
	$BodyParts/Head/HeadSprite.texture = head_texture
	$BodyParts/Body/BodySprite.texture = body_texture
	$BodyParts/LeftLeg/LeftLegSprite.texture = leg_texture
	$BodyParts/RightLeg/RightLegSprite.texture = leg_texture
	$BodyParts/LeftHand/LeftHandSprite.texture = left_hand_texture
	$BodyParts/RightHand/RightHandSprite.texture = right_hand_texture
