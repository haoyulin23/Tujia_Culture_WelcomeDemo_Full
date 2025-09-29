extends Node2D

@onready var stones := $StoneContainer.get_children().filter(func(n): return n.name.begins_with("Stone"))
@onready var catch_zone := $StoneContainer/CatchZone
@onready var timer := $Timer_Judge
@onready var label := $UI/Label_Instruction
@onready var button := $UI/Button_Next

var current_index := 0
var game_state := "idle"
var picked_count := 0
var pick_target := 0  # 本关要捡几颗

func _ready():
	button.pressed.connect(start_game)
	show_instruction("点击开始")

func start_game():
	current_index = 0
	picked_count = 0
	pick_target = 0
	game_state = "throw"
	button.hide()
	reset_all_stones()
	enable_current_stone(true)
	catch_zone.visible = false
	show_instruction("点击要抛起的石子")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var click_pos = event.position

		if game_state == "throw":
			if is_click_on_stone(click_pos, current_index):
				do_throw()

		elif game_state == "picking":
			for i in range(stones.size()):
				if i == current_index:
					continue  # 忽略抛起的石子
				if stones[i].visible and is_click_on_stone(click_pos, i):
					stones[i].visible = false
					picked_count += 1
					if picked_count >= pick_target:
						game_state = "waiting_catch"
						show_instruction("点击圈圈接住石子！")

		elif game_state == "waiting_catch":
			var drop_pos = stones[current_index].position + Vector2(0, 80)
			if click_pos.distance_to(drop_pos) < 60 and timer.time_left > 0.3:
				on_success()
				pick_target += 1
			else:
				on_fail()

func is_click_on_stone(pos: Vector2, index: int) -> bool:
	var stone: Sprite2D = stones[index]
	return stone.get_rect().grow(10).has_point(stone.to_local(pos))

func do_throw():
	var stone = stones[current_index]
	stone.position.y -= 100  # 抛起
	catch_zone.position = stone.position + Vector2(0, 100)
	catch_zone.visible = true

	picked_count = 0
	if pick_target == 0:
		game_state = "waiting_catch"
	else:
		game_state = "picking"
	show_instruction("快点击捡1颗石子！")

	timer.wait_time = 10
	timer.start()

func on_success():
	catch_zone.visible = false
	timer.stop()
	show_instruction("成功！进入下一轮")
	current_index += 1
	if current_index >= stones.size():
		game_state = "done"
		show_instruction("游戏完成！")
		button.text = "重玩"
		button.show()
	else:
		await get_tree().create_timer(1.0).timeout
		game_state = "throw"
		enable_current_stone(true)
		reset_all_stones()
		show_instruction("点击要抛起的石子")

func on_fail():
	catch_zone.visible = false
	show_instruction("失败了！点击重试")
	game_state = "fail"
	button.text = "重试"
	button.show()

func reset_all_stones():
	var center_x = 640  # 屏幕中心
	var base_y = 340    # 基础高度
	var spacing = 90    # 水平方向间隔
	var arc_height = 50 # 弧线高度

	for i in range(stones.size()):
		stones[i].visible = true
		var offset_x = (i - 2) * spacing
		var offset_y = -arc_height * (1 - abs(i - 2) / 2.0)  # 抛物线模拟
		stones[i].position = Vector2(center_x + offset_x, base_y + offset_y)

func enable_current_stone(show: bool):
	for i in range(stones.size()):
		stones[i].modulate = Color(1, 1, 1, 0.3)
	stones[current_index].modulate = Color(1, 1, 1, 1)

func show_instruction(text: String):
	label.text = text
	
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSelect.tscn")

func _on_in_button_pressed():
	$Panel.visible = true
	
func _on_close_button_pressed():
	$Panel.visible = false
	
