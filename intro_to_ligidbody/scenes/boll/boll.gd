extends RigidBody2D

@onready var random_rotation = (randf() * 30) - 1

func _ready():
	angular_velocity = random_rotation
