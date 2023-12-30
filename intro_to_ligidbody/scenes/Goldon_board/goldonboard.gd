extends Node2D

var packed_ball_scene = preload('res://scenes/boll/boll.tscn')
@onready var spawn_pos = $Marker2D.position


func _ready():
	$Timer.start()


func spawn_ball(pos):
	var ball_scene = packed_ball_scene.instantiate()
	ball_scene.position = pos
	$balls.add_child(ball_scene)
	

func _on_timer_timeout():
	spawn_ball(spawn_pos)
