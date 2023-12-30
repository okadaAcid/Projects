extends Node

@export var mob_scene: PackedScene
var score

#func _ready():
##	new_game()

func game_over():
	$ScoreTimer.stop()
	$Mobtimer.stop()
	$HUD.show_game_over()
	#このノードが含む子シーンを出力する。
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DethSound.play()
	
func new_game():
	score = 0
#	ここにPlayerをスポーンさせる
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

	$Music.play()

func _on_score_timer_timeout():
	score += 1
	#スコア表記をHUDに表示する
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$Mobtimer.start()
	$ScoreTimer.start()

func _on_mobtimer_timeout():
	#インスタンス化
	var mob = mob_scene.instantiate()
	#モブのスポーン場所を決める.ランダムな少数をパスのプログレス位置に指定する。
	$Path2D/MobSpawnLocation.progress_ratio = randf()
	
	#モブの向く方向を決める。
	var direction = $Path2D/MobSpawnLocation.rotation + PI / 2
	
	# モブのスポーン場所を適用する
	mob.position = $Path2D/MobSpawnLocation.position
	
	#モブの向く方向にランダム性を加える
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	#モブの速度を選ぶ
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# 実際にモブをスポーンさせる。
	add_child(mob)
	
	
	
	
