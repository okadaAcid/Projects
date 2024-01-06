extends Area3D

const ROT_SPEED = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotate_y(deg_to_rad(ROT_SPEED))
	
#	if has_overlapping_bodies():
#		queue_free()


func _on_body_entered(_body):
	queue_free()

