extends Node2D
class_name ConveyorObject

var speed: float = 150.0


func _physics_process(delta):
	var target_vel = self.transform.basis_xform(Vector2(1.0, 0.0)) * speed
	for body in $Area2D.get_overlapping_bodies():
		var rb = body as RigidBody2D
		if rb:
			var force = (target_vel - rb.linear_velocity) * delta
			rb.apply_central_impulse(force)
