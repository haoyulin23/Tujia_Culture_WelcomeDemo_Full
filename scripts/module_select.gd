extends Control

func _on_FolkArtButton_pressed():
	get_tree().change_scene_to_file("res://scenes/FolkArt.tscn")

func _on_InteractiveButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Interactive.tscn")

func _on_HistoryButton_pressed():
	get_tree().change_scene_to_file("res://scenes/History.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/AvatarSelect.tscn")
