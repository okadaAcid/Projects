extends CharacterBody2D

var speed = 300
#var pos = Vector2(-51,102)


# Called when the node enters the scene tree for the first time.
func _ready():
#	position = pos
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT
	position += direction * speed * delta
	move_and_slide()

func hit():
	print('damage')
	queue_free()

	
	
