extends Control

func _ready():
	print("Welcome to Tujia Culture Demo!")

func _on_start_button_pressed():
	print("Start Game Pressed")
	get_tree().change_scene_to_file("res://scenes/AvatarSelect.tscn")


func _on_video_button_pressed():
	$VideoPlayer.visible = true
	$VideoPlayer.play()

func _on_info_button_pressed():
	$InfoPanel.visible = true

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Welcome.tscn")
