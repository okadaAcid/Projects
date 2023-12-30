extends CharacterBody3D

signal hit

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	#入力
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	#第二引数は、グローバル座標において上方向とすべきローカルベクトル方向を代入する。
		$Pivot.look_at(position + direction, Vector3.UP)
		
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		#重力加速度を適用
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse

#すべての衝突回数に応じてループを開始
	for index in range(get_slide_collision_count()):
		# indexからその衝突を参照する。get_slide_collisionは、衝突情報を含んでおり、collider()メソッドでその衝突相手を参照できる
		var collision = get_slide_collision(index)
		
		#床と衝突しているとき
		if collision.get_collider() == null:
			continue
		
		#モブグループと衝突しているとき
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse
			break
			
#	アニメーション
	if direction != Vector3.ZERO:
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
		
	#落ちる挙動
#	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse
		
	velocity = target_velocity
	move_and_slide()
	
func die():
	hit.emit()
	queue_free()

func _on_mob_detector_body_entered(_body):
	die()
	
