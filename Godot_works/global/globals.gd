extends Node

#UIスクリプトに変更したことを示すシグナルを飛ばす。だがUIノードとつながっていないので、向こうでつなぐ。
signal stat_change

#レーザーの残機を管理
var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stat_change.emit()

#グレネードの残機を管理
var grenade_amount = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stat_change.emit()
		

var health = 60:
	#配下からこのプロパティにアクセス(主にprint文にて)しようとしたときにどんな処理をするか
	get:
		return health
	#配下からこのプロパティの値を更新しようとしたときにどんな処理をするか。valueは更新後の値。
	set(value):
		health = value 
		stat_change.emit()
		
		


