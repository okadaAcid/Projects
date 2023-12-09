extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("fade_to_black")
	# フェードアウトするアニメーション
	await $AnimationPlayer.animation_finished
	# sceneをロードする。
	get_tree().change_scene_to_file(target)
	# 現れるアニメーション
#	$AnimationPlayer.play("reveal")
	$AnimationPlayer.play_backwards("fade_to_black")
	
