extends Area2D

# このコードにはバグ(描画されないバグ)なし

#インスタンス化すると決定する変数
var rotation_speed: int = 4
var available_options = ['laser', 'laser', 'laser', 'grenade', 'health']
var type = available_options[randi()%len(available_options)]
#var type = 'grenade'
#var type = 'health'
#var type = 'laser'

var direction: Vector2
var distance: int = randi_range(150, 250)

#インスタンス化後に最初に呼び出される関数
func _ready():
	
	if type == 'laser':
		$Sprite2D.modulate = Color(0,0.25,0.6)
	if type == 'grenade':
		$Sprite2D.modulate = Color(0.8,0.2,0.1)
	if type == 'health':
		$Sprite2D.modulate = Color(0.1,0.8,0.1)
		
	# tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))
	
func _process(delta):
	rotation += rotation_speed * delta
	


#当たったら、プレイヤーのアイテム数を増やす
func _on_body_entered(_body):
	#よりすっきりした書き方。
	if type == 'health':
		Globals.health += 10
	elif type ==  'laser':
		Globals.laser_amount += 5
	elif type == 'grenade':
		Globals.grenade_amount += 1
	
	queue_free()
#
