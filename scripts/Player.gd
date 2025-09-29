extends AnimatedSprite2D

@export var move_speed := 100
@export var min_x := 100  # 左边界限制
@export var max_x := 1000  # 右边界限制

var is_kicking = false

# 通过导出变量链接 Jianzi 节点（在主场景中绑定）
@export var jianzi_node: NodePath
var jianzi: Node2D

func _ready():
	play("idle")
	if jianzi_node != null:
		jianzi = get_node(jianzi_node)

func _process(delta):
	if is_kicking:
		return  # 踢腿时不允许移动

	var moved = false

	if Input.is_action_pressed("ui_right"):
		position.x += move_speed * delta
		#flip_h = false
		moved = true
	elif Input.is_action_pressed("ui_left"):
		position.x -= move_speed * delta
		#flip_h = true
		moved = true

	# 屏幕边界限制
	position.x = clamp(position.x, min_x, max_x)

	if moved and animation != "idle":
		play("idle")

#func _input(event):
	#if event.is_action_pressed("ui_accept") and not is_kicking:
		## 检测是否靠近毽子，才允许踢
		#if jianzi and abs(position.x - jianzi.global_position.x) < 60:
			#jianzi.call("bounce")  # 调用毽子的弹跳函数
			#is_kicking = true
			#play("kick")

func _input(event):	
	if event.is_action_pressed("ui_accept") and not is_kicking:
		play("kick")
		is_kicking = true

func _on_AnimatedSprite2D_animation_finished():
	if animation == "kick":
		play("idle")
		is_kicking = false

# 踢腿时距离够近才让毽子弹起
	if jianzi and abs(position.x - jianzi.global_position.x) < 60:
		jianzi.bounce()
		is_kicking = true
		play("kick")

func _on_RestartButton_pressed():
	var jianzi = get_node("/root/KickJianzi/Jianzi")  # 请根据实际路径调整
	if jianzi:
		jianzi.reset_position()  # 推荐用这个函数，逻辑清晰
		# jianzi._on_reset_timer_timeout()  # 或者用这个直接模拟定时器超时，二选一


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSelect.tscn")
