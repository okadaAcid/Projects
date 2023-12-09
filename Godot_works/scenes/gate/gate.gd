extends StaticBody2D

signal player_gate_enterd(body)




func _on_area_2d_body_entered(body):
	player_gate_enterd.emit(body)





