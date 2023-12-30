extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#mobタイプを選択。
	# spriteanimationの名称リストを取得
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	

#画面外から出たら、自身を削除する。
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	
