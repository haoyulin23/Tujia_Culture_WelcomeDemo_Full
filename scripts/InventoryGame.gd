extends Node
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Location_Fenghuang_Interact.tscn")

func _on_ConfirmButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
