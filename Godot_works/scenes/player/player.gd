extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

signal laser_emit(pos,direction)
signal grenade_emit(pos,direction)


func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
#move_and_slideを呼び出す前に、CharacterBody2Dのvelocityを更新する
	velocity = direction * speed
#move_and_slideは当たり判定をboolで返す。Trueであれば、velocityを0にする。
	move_and_slide()
	
# rotate
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
#		# レーザーの残機を減らす。
		Globals.laser_amount -= 1
		# GPUParticlesをone shot でONにする。
		$GPUParticles2D.emitting = true
		#ランダムに３つのMarker２Dから１つを選ぶ.markerは、スポーンに使えそう。
		var laser_markers = $LaserStartPositions.get_children()
		#選ばれたマーカーを格納する.randint()を三のあまりで分類して返す
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		
#		var _laser_rotation = global_rotation
		#そのMarker２Dの座標をlevelノードにエミットしてやる
		laser_emit.emit(selected_laser.global_position,player_direction)
		can_laser = false
		$Leaser_timer.start()
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		# グレネードの残機を減らす
		Globals.grenade_amount -= 1
#randomly select grenade position to spawn
		var grenade_markers = $LaserStartPositions.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		
		#levelノードにスポーン場所を連絡する
		grenade_emit.emit(selected_grenade.global_position,player_direction)
		can_grenade = false
		$Grenade_timer.start()
		
		


func _on_timer_timeout():
	can_laser = true # Replace with function body.



func _on_grenade_timer_timeout():
	can_grenade = true # Replace with function body.


		
		
