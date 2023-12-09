extends LevelParent

#exportすると、タブから操作可能になる。
#@export var outside_level_scene: PackedScene 
	
func _on_gate_player_gate_enterd(_body):
	#	get_tree()いらない。処理させたい対象が、入れ子ではないから。
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
#	同じくシーン遷移する。
#	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
#	get_tree().change_scene_to_packed(outside_level_scene)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
	
