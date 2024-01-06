extends CanvasLayer
class_name UI

@onready var score_label = %Score_label
@onready var time_limit_label = %Time_limit_label

var time_limit = 100
#	set(new_score):
#		score = new_score
#		_update_score_label()

func _ready():
	_update_score_label(0)

func _update_score_label(num):
	score_label.text = str(num)

func _update_timer():
	time_limit -= 1
	time_limit_label.text = str(time_limit)
	
	
	

#func _on_timer_timeout():
#	self.score += 100

func  _on_change_num_of_balloon(num):
	_update_score_label(num)
