extends Area2D

#スピードの設定 @export をvar変数の先頭につけると、Inspectorタブで扱えるようになる。
@export var speed: int = 1000
# 初期化用にVector2.LEFTを入れておく。
var direction: Vector2 = Vector2.LEFT

func _ready():
	$SelfDestructTimer.start()


func _process(delta):
	#常にプレイヤーが発射した方向に移動させる。
	position += speed * direction * delta

func _on_self_destruct_timer_timeout():
	queue_free()
	

#レーザーの当たり判定
func _on_body_entered(body):
#	if body.has_method("hit"):
#		body.hit()
	if "hit" in body:
		body.hit()
	# レーザーを削除する
	queue_free()
	





