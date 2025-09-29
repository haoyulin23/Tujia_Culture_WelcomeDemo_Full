
extends Control

func _ready():
	var selected_avatar = Global.selected_avatar
	$CharacterSprite.texture = load(selected_avatar)

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Welcome.tscn")
