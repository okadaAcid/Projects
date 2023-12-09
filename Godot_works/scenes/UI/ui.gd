extends CanvasLayer

# colors
var green: Color = Color("6bbfa3") 
var red: Color = Color(0.9,0,0,1)

#アクセス参照する＄に関しては、_ready()が呼ばれて初めて使えるようになる。（ルートノード->子ノードの順番だから）よって、@onreadyがいる。
@onready var laser_label: Label = $LaserContainer/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadContainer/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserContainer/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadContainer/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/ProgressBar

func _ready():
	#　Globalsのhealth_changesignalの受け手として、update_health_text関数を指定する。
	#第一引数のsingalは、発出されている必要がある
	Globals.connect("stat_change", update_stats)

	
		# グローバル設定の値で初期化する。
	update_laser_text()
	update_grenade_text()
	update_health_text()
	

func update_stats():
	#Globalノードから変更を伝えるシグナルが来たら、変更する。
	update_laser_text()
	update_grenade_text()
	update_health_text()
	


	

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green


func update_laser_text():
	"""レーザーの残機を表示する。Labelへのアクセスは、メンバ変数に持っておく、だが、readyが呼ばれない
	限り、アクセス変数が宣言されない。だから、@onreadyを付けることで、利用可能にできると同時に、その
	スクリプト内ではグローバルに使えるようになる。"""
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_health_text():
	health_bar.value = Globals.health
	

	
	
	
	
	
