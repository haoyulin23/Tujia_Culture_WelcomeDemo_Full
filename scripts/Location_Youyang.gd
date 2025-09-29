extends Node2D

@onready var btn_continue := $ContinueButton
@onready var btn_back := $BackButton

func _ready():
	btn_continue.pressed.connect(_on_continue_pressed)
	btn_back.pressed.connect(_on_back_pressed)
	
func _on_continue_pressed():
	Global.unlocked_locations["Fenghuang"] = true
	get_tree().change_scene_to_file("res://scenes/DressUp.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
