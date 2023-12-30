extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(_delta):
	move_and_slide()
	
#mainsceneから呼ばれる関数。スポーン場所とプレイヤーの座標を引数として、向きと移動方向を決定する。
func initialize(start_position, player_position):
	# 第三引数のローカルベクトルを世界におけるグローバル座標の上向きベクトルと対応させる。そしてベクトルを第一から第二の座標に従うベクトル方向に向かせる。
	look_at_from_position(start_position, player_position, Vector3.UP)
	# 変動を加える
	rotate_y(randf_range(-PI/4, PI/4))
	# スピードを決定
	var random_speed = randi_range(min_speed, max_speed)
	
	# まず、velocityを初期化
	velocity = Vector3.FORWARD * random_speed
	#rotation.yにしたがって、Vector3UPの向きを中心としてかいてんさせたものをvelocityとする、
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	#ランダム速度に応じてアニメーションスピードを変化させる。
	$AnimationPlayer.speed_scale = random_speed / min_speed
	
#visibilitynotifierからの画面外シグナルに応じ、自身を削除
func _on_visibility_notifier_screen_exited():
	queue_free()
	
func squash():
	squashed.emit()
	queue_free()
	
	
	
