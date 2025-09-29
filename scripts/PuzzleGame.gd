#extends Node2D
#
#@onready var puzzle_container := $GridContainer
#@onready var timer_label := $TimerLabel
#@onready var reference_image := $ReferenceImage
#@onready var back_button := $BackButton
#@onready var grid := $GridContainer
#@onready var toggle_ref_button := $ToggleRefButton
#
#const TILE_COUNT = 25
#const TILE_PATH = "res://assets/puzzle/puzzle_piece_"
#const SOURCE_IMAGE = preload("res://assets/puzzle_source.png")
#const SAVE_PATH = "res://assets/puzzle/"
#const TILE_SIZE = Vector2(80, 80)
#const GRID_WIDTH = 5
#const GRID_HEIGHT = 5
#const TARGET_SIZE = Vector2(400, 400)
#
#var elapsed_time := 0.0
#var first_selected_piece : TextureButton = null
#var pieces = []
#var correct_order = []
#var is_ref_visible := true
#
#func _ready():
	#set_process(true)
	#reference_image.texture = preload("res://assets/puzzle_source.png")
	#print("✅ Initialize puzzle tiles...")
#
	#_generate_tiles()
	#
	#var all_tiles = []
	#for i in range(TILE_COUNT):
		#var tex := load(TILE_PATH + str(i) + ".tres")
		#var btn := TextureButton.new()
		#btn.texture_normal = tex
		#btn.name = str(i)
		#btn.custom_minimum_size = TILE_SIZE
		#btn.pressed.connect(on_piece_pressed.bind(btn))
		#all_tiles.append(btn)
		#correct_order.append(btn.name)
		#
	#all_tiles.shuffle()
	#for btn in all_tiles:
		#puzzle_container.add_child(btn)
		#pieces.append(btn)
	#
	#back_button.pressed.connect(_on_BackButton_pressed)
	#toggle_ref_button.pressed.connect(_on_ToggleRefButton_pressed)
#
#func _generate_tiles():
	#print("🔧 Generate puzzle tile textures AtlasTexture")
#
	#var image = SOURCE_IMAGE.get_image()
	#image.convert(Image.FORMAT_RGBA8)  # 确保格式正确
	#image.resize(400, 400, Image.INTERPOLATE_LANCZOS)
#
	#var tex := ImageTexture.create_from_image(image)
#
	#print("✅ 原图已缩放为：", Vector2(tex.get_width(), tex.get_height()))
#
	#for y in range(GRID_HEIGHT):
		#for x in range(GRID_WIDTH):
			#var atlas_tex := AtlasTexture.new()
			#atlas_tex.atlas = tex
			#atlas_tex.region = Rect2(x * TILE_SIZE.x, y * TILE_SIZE.y, TILE_SIZE.x, TILE_SIZE.y)
#
			#var index = y * GRID_WIDTH + x
			#var file_path = "%spuzzle_piece_%d.tres" % [SAVE_PATH, index]
			#ResourceSaver.save(atlas_tex, file_path)
			#print("🧩 Generate:", file_path)
		#
#func on_piece_pressed(btn: TextureButton):
	#if first_selected_piece == null:
		#first_selected_piece = btn
		#btn.modulate = Color(1, 1, 0.6)  # 选中颜色
	#else:
		#var index1 = grid.get_children().find(first_selected_piece)
		#var index2 = grid.get_children().find(btn)
#
		#if index1 != -1 and index2 != -1:
			#grid.move_child(first_selected_piece, index2)
			#grid.move_child(btn, index1)
#
		#first_selected_piece.modulate = Color(1, 1, 1)
		#first_selected_piece = null
#
		## ✅ 等待一帧，让节点顺序更新后再执行完成判断
		#await get_tree().process_frame
		#if _check_completion():
			#print("🎉 拼图完成！")
#
#func _check_completion():
	#for i in range(grid.get_child_count()):
		#var tile = grid.get_child(i)
		#if tile.name != str(i) :
			#return false
	#return true
#
#func _process(delta):
	#elapsed_time += delta
	#var minutes = int(elapsed_time / 60)
	#var seconds = int(elapsed_time) % 60
	#timer_label.text = "Time: %02d:%02d" % [minutes, seconds]
#
#func _on_BackButton_pressed():
	#get_tree().change_scene_to_file("res://scenes/ModuleSelect.tscn")
#
#func _on_ToggleRefButton_pressed():
	#is_ref_visible = !is_ref_visible
	#reference_image.visible = is_ref_visible

extends Node2D

@onready var puzzle_container := $GridContainer
@onready var timer_label := $TimerLabel
@onready var reference_image := $ReferenceImage
@onready var back_button := $BackButton
@onready var toggle_ref_button := $ToggleRefButton
@onready var completion_label := $CompletionLabel
@onready var next_button := $NextButton

const TILE_COUNT = 25
const TILE_PATH = "res://assets/puzzle/puzzle_piece_"
const SOURCE_IMAGE = preload("res://assets/puzzle_source.png")
const SAVE_PATH = "res://assets/puzzle/"
const TILE_SIZE = Vector2(80, 80)
const GRID_WIDTH = 5
const GRID_HEIGHT = 5
const TARGET_SIZE = Vector2(400, 400)

var elapsed_time := 0.0
var first_selected_piece: TextureButton = null
var pieces = []
var correct_order = []
var is_ref_visible := true

func _ready():
	set_process(true)

	reference_image.visible = false
	is_ref_visible = false

	# 隐藏完成提示和下一关按钮
	completion_label.visible = false
	next_button.visible = false

	print("✅ Initialize puzzle tiles...")

	_generate_tiles()

	var all_tiles = []
	for i in range(TILE_COUNT):
		var tex := load(TILE_PATH + str(i) + ".tres")
		var btn := TextureButton.new()
		btn.texture_normal = tex
		btn.name = str(i)
		btn.custom_minimum_size = TILE_SIZE
		btn.pressed.connect(on_piece_pressed.bind(btn))
		all_tiles.append(btn)
		correct_order.append(btn.name)

	all_tiles.shuffle()
	for btn in all_tiles:
		puzzle_container.add_child(btn)
		pieces.append(btn)

	# 连接按钮事件
	back_button.pressed.connect(_on_BackButton_pressed)
	toggle_ref_button.pressed.connect(_on_ToggleRefButton_pressed)
	next_button.pressed.connect(_on_NextButton_pressed)

func _generate_tiles():
	print("🔧 Generating puzzle tile textures...")

	var image = SOURCE_IMAGE.get_image()
	image.convert(Image.FORMAT_RGBA8)
	image.resize(400, 400, Image.INTERPOLATE_LANCZOS)

	var tex := ImageTexture.create_from_image(image)

	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			var atlas_tex := AtlasTexture.new()
			atlas_tex.atlas = tex
			atlas_tex.region = Rect2(x * TILE_SIZE.x, y * TILE_SIZE.y, TILE_SIZE.x, TILE_SIZE.y)

			var index = y * GRID_WIDTH + x
			var file_path = "%spuzzle_piece_%d.tres" % [SAVE_PATH, index]
			ResourceSaver.save(atlas_tex, file_path)
			print("🧩 Saved:", file_path)

func on_piece_pressed(btn: TextureButton):
	if first_selected_piece == null:
		first_selected_piece = btn
		btn.modulate = Color(1, 1, 0.6)
	else:
		var index1 = puzzle_container.get_children().find(first_selected_piece)
		var index2 = puzzle_container.get_children().find(btn)

		if index1 != -1 and index2 != -1:
			puzzle_container.move_child(first_selected_piece, index2)
			puzzle_container.move_child(btn, index1)

		first_selected_piece.modulate = Color(1, 1, 1)
		first_selected_piece = null

		await get_tree().process_frame
		if _check_completion():
			print("🎉 拼图完成！")
			completion_label.text = "Congralation！"
			completion_label.visible = true
			next_button.visible = true

func _check_completion():
	for i in range(puzzle_container.get_child_count()):
		var tile = puzzle_container.get_child(i)
		if tile.name != str(i):
			return false
	return true

func _process(delta):
	elapsed_time += delta
	var minutes = int(elapsed_time / 60)
	var seconds = int(elapsed_time) % 60
	timer_label.text = "Time: %02d:%02d" % [minutes, seconds]

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/ModuleSelect.tscn")

func _on_ToggleRefButton_pressed():
	is_ref_visible = !is_ref_visible
	reference_image.visible = is_ref_visible

func _on_NextButton_pressed():
	get_tree().change_scene_to_file("res://scenes/NextPuzzleScene.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Welcome.tscn")
