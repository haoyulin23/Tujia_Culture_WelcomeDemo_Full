extends Node

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/ModuleSelect.tscn")

@onready var btn_continue := $Btn_Continue

func _ready():
	btn_continue.pressed.connect(_on_continue_pressed)

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
