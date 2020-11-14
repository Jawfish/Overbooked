extends KinematicBody2D
class_name Actor

signal moving
signal idle

export (int) var movement_speed: int = 100

var direction: Vector2
