extends Node3D


signal change_num_of_balloon(num)
signal level_clear


@onready var hud_playing = $HUD_playing

#var balloon: PackedScene = preload("res://scenes/balloon.tscn")
@onready var num_of_balloons = get_tree().get_nodes_in_group("balloon_group").size():
	set(new_value):
		num_of_balloons = new_value
		change_num_of_balloon.emit(num_of_balloons)


##これをGameNodeのループ内で回してもいい。
func is_clear() -> bool:
	#風船の数が0であることを知らせる
	return num_of_balloons == 0
	
func _ready():
	if !self.change_num_of_balloon.is_connected(hud_playing._on_change_num_of_balloon):
		self.change_num_of_balloon.connect(hud_playing._on_change_num_of_balloon)

func _process(delta):
	num_of_balloons = get_tree().get_nodes_in_group("balloon_group").size()
	
	if is_clear():
		print('clear')
		
		
#タイムリミットの管理
func _on_time_limit_timer_timeout():
	hud_playing._update_timer()
