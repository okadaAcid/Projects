extends RigidBody2D

const speed = 700

func explode():
	$AnimationPlayer.play("only_explosion")
