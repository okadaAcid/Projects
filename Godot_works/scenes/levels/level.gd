extends Node2D
class_name LevelParent

	#動的なsceneの作成１：インスタンス化したいsceneをpreloadする。
var laser_scene: PackedScene = preload("res://scenes/laser/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/granade/granade.tscn")
var item_scene: PackedScene = preload("res://scenes/item/Item.tscn")


func _ready():
	# Containerに属するノードのリストを取得し、取り出す。
	for container in get_tree().get_nodes_in_group('Container'):
		# containerに属するノードが発する、openシグナルと、_on_container_opened関数をつなぐ
		container.connect("open", _on_container_opened)
		
func _on_container_opened(pos, direction):
	# openシグナルを受け取った後の処理. 受け取った引数から、スポーン座量を決定する。
	
	# インスタンス化
	var item = item_scene.instantiate()
#	# インスタンス化後の座標を、受け取った座標にする。
	item.position = pos
	item.direction = direction
#	# levelノード配下の、Items_nodeに、インスタンス化したノードを追加する。]
#	call_deferred("$Node.set_monitoring", false)
	$Items.call_deferred('add_child', item)
	print('instantiate! ')
		
	

func _on_player_laser_emit(pos,direction):
	#動的なsceneの作成２:インスタンス化する。
	var laser = laser_scene.instantiate()
	#インスタンス化したlaserクラスは、Playerノードのposにスポーンする。プレイヤーパスを指定
	#単にパスを指定したときは、そのクラスのルートノードのposition等が意味される。
	laser.position = pos
	#direcitonベクトルの方向を、radianに変換し、それをdegreeに変換して、rotation_degreeにする。
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
#	laser.rotation = direction.angle()
	#動的なsceneの作成３:インスタンス化したsceneはしかるべき所においておく
	#ここではlevelの子ノードとして加える。
	$Projectiles.add_child(laser)
#	print("laser from level") # Replace with function body.

#	レーザーの残機数を表示。残機の減少は、player.gdで管理。
	$UI.update_laser_text()


func _on_player_grenade_emit(pos,direction):
#インスタンス化:インスタンス化すると、＄を付けなくともアクセス可能
#as 以下は付けなくともかまわない。ルートの型を明記するため
	var grenade = grenade_scene.instantiate() as RigidBody2D
#スポーン
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
	$UI.update_grenade_text()


func _on_house_player_entered():
#	Returns the SceneTree that contains this node.
	var tween = get_tree().create_tween()
#	playerノード配下のCamera2Dノードのzoom属性を一秒間でVector2(1,1)まで変化させる。
#	以下のように、上から下へ順番にその変化が適用される。つまり以下のコードでは、zoom --> 透明化の
#	順番に起きる。
#	tween.set_parallel(true) # これ使うと、以下の変化が同時に起きる
	
#	tween.tween_property($Player/Camera2D,"zoom",Vector2(1,1),1)
#	シグモイド関数的な動き
	tween.tween_property($Player/Camera2D,"zoom",Vector2(1,1),1).set_trans(Tween.TRANS_QUAD)
	
#	tween.tween_property($Player, "modulate:a",0,2).from(0.5)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom",Vector2(0.6,0.6),1)
#
