extends Area2D

var original_position
var is_correctly_placed = false
@onready var sprite = $Sprite2D
var drag_offset = Vector2.ZERO

func _ready():
	original_position = position
	input_pickable = true
	z_index = 100

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		drag_offset = get_global_mouse_position() - global_position
		start_drag()

func start_drag():
	set_process(true)

func _process(delta):
	if is_processing():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			global_position = get_global_mouse_position() - drag_offset
		else:
			set_process(false)
			call_deferred("check_drop")

func check_drop():
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		print("⚪️ 檢查重疊區域：", area.name)

		print(name, area.name)
		if name == "Item_drum" and area.name == "TargetArea_drum":
			print("✅ 鼓 放置成功")
			is_correctly_placed = true
			global_position = position
			set_process(false)
			input_pickable = false
			return

	if is_correctly_placed == false:
		global_position = original_position
		print("❌ 放錯了，回到原位")
