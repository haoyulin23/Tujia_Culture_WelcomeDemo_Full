
extends Control

#@onready var avatar_preview = $AvatarContainer/AvatarPreview

var avatars = [
	"res://assets/avater/avater1.png",
	"res://assets/avater/avater2.png",
	"res://assets/avater/avater3.png",
	"res://assets/avater/avater4.png"
]
var current_index = 0

func _ready():
	update_avatar()

func update_avatar():
	var texture = load(avatars[current_index])
	$AvatarContainer/AvatarPreview.texture = texture

func _on_left_button_pressed():
	current_index = (current_index - 1 + avatars.size()) % avatars.size()
	update_avatar()

func _on_right_button_pressed():
	current_index = (current_index + 1) % avatars.size()
	update_avatar()

func _on_confirm_button_pressed():
	print("Selected avatar:", avatars[current_index])
	# 可以在这里保存选择，例如：
	# Global.selected_avatar = avatars[current_index]
	Global.selected_avatar = avatars[current_index]
	get_tree().change_scene_to_file("res://scenes/ModuleSelect.tscn")
	
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Welcome.tscn")
