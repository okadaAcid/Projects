extends Node

@export var mob_scene: PackedScene


#　モブをスポーンさせ、移動方向を決める、
func _on_mob_timer_timeout():
	
	#1. mobをインスタンス化
	var mob = mob_scene.instantiate()
	
	#2. ランダムにスポーン場所を選ぶ
	#ランダムな座標をPathにおいて取得、その前に、SpawnLocationへの参照を取得
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	#ランダムオフセットを加える。プログレスレシオはパスの進行度を示す。(0-1)
	mob_spawn_location.progress_ratio = randf()
	
	#　プレイヤーの位置を取得する。
	var player_position = $Player.position
	
	#モブの移動方向を決めるinitializeメソッドを呼び出し、使う
	mob.initialize(mob_spawn_location.position, player_position)
	
	#nodetreeに加えることでスポーンが完了する
	add_child(mob)
	
	
	
