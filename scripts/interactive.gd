extends Node
@export var avatar_icon: TextureRect

func _ready():
	var tex: Texture2D = load(Global.selected_avatar)
	avatar_icon.texture = tex
	print("Selected avatar:", Global.selected_avatar)

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/ModuleSelect.tscn")

func _on_ContinueButton_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSelect.tscn")
