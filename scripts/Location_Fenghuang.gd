extends Node2D

@onready var continue_button := $ContinueButton

func _ready():

	continue_button.pressed.connect(_on_continue_pressed)

func _on_continue_pressed():
	# ✅ 解锁凤凰
	Global.unlocked_locations["Fenghuang"] = true
	Global.save_progress()
	
	Global.unlocked_locations["Fenghuang"] = true
	Global.save_progress()
	get_tree().change_scene_to_file("res://scenes/Location_Fenghuang_Interact.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
