extends CharacterBody3D

@onready var camera_pivot_y = $CameraPivot_y
@onready var camera_pivot_x = $CameraPivot_y/CameraPivot_X
@onready var player_mesh = $player_mesh



const SPEED = 5.0
const JUMP_VELOCITY = 4.5
#方向キーを押したときにキャラクターに加えられる力
const LERP_VAL = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	#マウスをキャプチャする。
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, camera_pivot_y.rotation.y)
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, LERP_VAL)
		velocity.z = lerp(velocity.z, direction.z * SPEED, LERP_VAL)
		player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(-velocity.x, -velocity.z), LERP_VAL)
	else:
		#force単位でfromからtoまで減衰させる。こっちのほうが見栄えいい。
		velocity.x = lerp(velocity.x, 0.0, LERP_VAL)
		velocity.z = lerp(velocity.z, 0.0, LERP_VAL)
		
		#delta時間単位でfromからtoまで減衰させる
#		velocity.x = move_toward(velocity.x, 0, 0.01)
#		velocity.z = move_toward(velocity.z, 0, 0.01)

	move_and_slide()


func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		camera_pivot_y.rotate_y(-event.relative.x * 0.005)
		camera_pivot_x.rotate_x(-event.relative.y * 0.005)
		camera_pivot_x.rotation.x = clamp(camera_pivot_x.rotation.x , -PI/4, PI/4)
