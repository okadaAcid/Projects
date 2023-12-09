extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		# spawn候補から、子ノードをランダムに選び（indexで指定）, そのグローバル座標を取得する。
		for i in range(5):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			# 親ノードから継承したシグナル。current_directionも継承したシグナル。
			open.emit(pos, current_direction)
		opened = true
	
#	Containerグループに属するnodeを確認する。
#	print(get_tree().get_nodes_in_group("Container"))
	
