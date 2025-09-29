#extends Control  # 根如果是 Control；否则换成实际类型
#
## 最稳：用唯一名（Unique Name）+ %
#@onready var circle_mask: TextureRect = $CircleMask
#
#func _ready() -> void:
	## Debug：看看到底找没找到
	#if circle_mask == null:
		#push_error("[AvatarBadge] CircleMask NOT found. Check node name or set Unique Name.")
		#print_tree_pretty()
		#return
	#
	#circle_mask.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	##circle_mask.expand_mode  = TextureRect.EXPAND_FIT_BOTH
	#
	#var path := Global.selected_avatar as String
	#print("PATH: ", Global.selected_avatar)
	#if path == "" or !ResourceLoader.exists(path):
		#path = "res://assets/ui/default_avatar.png"
	#
	#var tex: Texture2D = load(path)
	#if tex == null:
		#push_error("[AvatarBadge] Failed to load texture: " + path)
		#return
#
	#circle_mask.texture = tex
	#print("[AvatarBadge] OK set texture:", path)
	
extends Control
@onready var circle_mask: TextureRect = $CircleMask

func _ready() -> void:
	# 1) 让 AvatarBadge 有可见尺寸并放到左上角
	set_anchors_preset(Control.PRESET_TOP_LEFT)
	position = Vector2(20, 20)                 # 距离左上角的边距
	custom_minimum_size = Vector2(72, 72)       # 你要的头像尺寸
	size = Vector2(72, 72)                      # 直接给一个初始 size
	z_index = 100                               # 确保在最上层（可选）

	# 2) 让 CircleMask 填满整个 Badge
	circle_mask.set_anchors_preset(Control.PRESET_FULL_RECT)
	circle_mask.size = size
	circle_mask.visible = true
	circle_mask.modulate = Color(1,1,1,1)

	# （如果用了圆形遮罩的 Shader，这两行能保证铺满）
	circle_mask.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	#circle_mask.expand_mode  = TextureRect.EXPAND_FIT_BOTH

	# 3) 加载纹理
	var path: String = Global.selected_avatar
	if path.is_empty() or !ResourceLoader.exists(path):
		path = "res://assets/ui/default_avatar.png"

	var tex: Texture2D = load(path)
	if tex == null:
		push_error("[AvatarBadge] Failed to load: " + path); return
	circle_mask.texture = tex

	# 4) 调试输出（确认位置与尺寸）
	print("[AvatarBadge] pos=", position, " size=", size, " cm.size=", circle_mask.size)
