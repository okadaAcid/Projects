extends Node2D

var max_children = 1000

func _process(_delta):
	if get_child_count() > max_children:
		var oldest_child = get_child(0)
		remove_child(oldest_child)
		oldest_child.queue_free()
		
	

