extends Node2D

var packed_ball_scene = preload("res://scenes/boll/boll.tscn")
var packed_bar_scene = preload("res://bar/bar.tscn")


func _ready():
	var rows = 10 # パスカルの三角形の行数
	var spacing = 68 # オブジェクト間のスペース
	for i in range(rows):
		var row = get_pascal_row(i)
		for j in range(len(row)):
			# カスタムシーンのインスタンスを作成
			var instance = packed_bar_scene.instantiate()
			instance.position = Vector2(j * spacing, i * spacing)
			print(j, i)
			add_child(instance)
			
func get_pascal_row(row_number):
	var row = [1]
	if row_number > 0:
		var previous_row = get_pascal_row(row_number - 1)
		for i in range(1, len(previous_row)):
			row.append(previous_row[i - 1] + previous_row[i])
		row.append(1)
	return row
