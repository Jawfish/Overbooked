extends Node2D


# succ
func succ(succee, succer) -> void:
	if succee and succer:
		$Tween.interpolate_property(
			succee, "position", succee.position, succer.position, 0.2, Tween.TRANS_EXPO
		)
		$Tween.interpolate_property(succee, "scale", succee.scale, Vector2.ZERO, 0.2, Tween.TRANS_EXPO)
		$Tween.start()
		yield($Tween, "tween_completed")
		succee.get_parent().remove_child(succee)
	$Audio.position = succer.position
	$Audio.pitch_scale = rand_range(0.8, 1.2)
	$Audio.play()
