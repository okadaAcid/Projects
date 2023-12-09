extends StaticBody2D
class_name ItemContainer

#　before ready()
#var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false
signal open(pos, direction)

# ready:
# applying rotation
# creating the node
