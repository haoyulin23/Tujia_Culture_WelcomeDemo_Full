extends Node
func _on_ContinueButton_pressed():
	get_tree().change_scene_to_file("res://scenes/InventoryGame.tscn")
	
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
