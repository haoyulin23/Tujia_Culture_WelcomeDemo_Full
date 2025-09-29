extends Node2D

@onready var btn_youyang := $Btn_Youyang
@onready var btn_fenghuang := $Btn_Fenghuang

func _ready():
	Global.load_progress()

	_update_location_button(
		btn_youyang,
		"Youyang",
		"res://assets/button_normal.png",
		"res://assets/button_hover.png",
		"res://assets/button_pressed.png",
		"res://assets/button_locked.png"
	)

	_update_location_button(
		btn_fenghuang,
		"Fenghuang",
		"res://assets/button_normal.png",
		"res://assets/button_hover.png",
		"res://assets/button_pressed.png",
		"res://assets/button_locked.png"
	)

func _update_location_button(
	button: TextureButton,
	location_key: String,
	normal_path: String,
	hover_path: String,
	pressed_path: String,
	locked_path: String
):
	var is_unlocked = Global.unlocked_locations.get(location_key, false)

	if is_unlocked:
		button.texture_normal = load(normal_path)
		button.texture_hover = load(hover_path)
		button.texture_pressed = load(pressed_path)
		button.disabled = false
		button.tooltip_text = ""
	else:
		button.texture_normal = load(locked_path)
		button.texture_hover = load(locked_path)
		button.texture_pressed = load(locked_path)
		button.disabled = true
		button.tooltip_text = "该地点尚未解锁"

# -----------------------
# 点击事件处理
# -----------------------

func _on_Btn_Youyang_pressed():
	if Global.unlocked_locations.get("Youyang", false):
		get_tree().change_scene_to_file("res://scenes/Location_Youyang.tscn")

func _on_Btn_Fenghuang_pressed():
	if Global.unlocked_locations.get("Fenghuang", false):
		get_tree().change_scene_to_file("res://scenes/Location_Fenghuang.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/ModuleSelect.tscn")
