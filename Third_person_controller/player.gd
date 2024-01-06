extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/mixamo_base/AnimationPlayer
@onready var visuals = $visuals


var SPEED = 3.0
const JUMP_VELOCITY = 4.5

var walking_speed = 3.0
var running_speed = 5.0
var is_running = false
#キック中にあるかどうか
var is_locked = false

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # マウスがゲーム内で不可視になる。

#イベントリストを受け取る関数
func _input(event):
	#マウスモーションならば
	if event is InputEventMouseMotion:
		#relative to the previous motion
		# xの動きに応じてローカルキャラクター座標をキャラクターローカルy軸中心に回転させる。sens_horizontalで減衰させる
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		#振れ幅が大きすぎるので、以下は使わない。
#		rotate_y(event.relative.x)

		# playerは逆回転させて見かけ上動かないようにする。
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		#yの動きに応じてカメラマウント座標をキャラクターローカルx軸中心に回転させる。
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))
		
	

func _physics_process(delta):
	
	if !animation_player.is_playing():
		is_locked = false
		
	
	
	if Input.is_action_just_pressed("kick"):
		if animation_player.current_animation != "kick":
			animation_player.play("kick")
			is_locked = true
			
	
	if Input.is_action_pressed("run"):
		SPEED = running_speed
		is_running = true
	else:
		SPEED = walking_speed
		is_running = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if !is_locked:
			if is_running:
				if animation_player.current_animation != "running":
					animation_player.play("running")
			else:
				if animation_player.current_animation != "walking":
					animation_player.play("walking")
					
			# playerをdirectionの方向に向けるオフセットとしてpositionを与え、その和とする。
			#　キック中でなければlook_atを適用
			visuals.look_at(position + direction)
			
		
		# playerをdirectionの方向に向けるオフセットとしてpositionを与え、その和とする。
		#　キック中でなければlook_atを適用
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "idle" and is_locked != true:
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#キック中でなければ慣性を適用
	if !is_locked:
		move_and_slide()
