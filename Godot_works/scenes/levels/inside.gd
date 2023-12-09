extends LevelParent


func _on_exit_gate_area_body_entered(_body):
	#	get_tree()いらない。処理させたい対象が、入れ子ではないから。
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
