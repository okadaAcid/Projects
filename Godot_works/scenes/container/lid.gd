extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		# 親ノードから継承したシグナル。current_directionも継承したシグナル。
		open.emit(pos, current_direction)
		opened = true
