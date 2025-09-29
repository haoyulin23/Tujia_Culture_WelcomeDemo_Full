extends Node2D  # 或 Control，看你场景根节点

@onready var kickjianzi_button = $VBoxContainer/KickJianziButton
@onready var quizgame_button = $VBoxContainer/QuizGameButton
@onready var fivestone_button = $VBoxContainer/FiveStoneGameButton

func _ready():
	kickjianzi_button.pressed.connect(_on_KickJianzi_pressed)
	quizgame_button.pressed.connect(_on_QuizGame_pressed)
	fivestone_button.pressed.connect(_on_FiveStone_pressed)

func _on_KickJianzi_pressed():
	get_tree().change_scene_to_file("res://scenes/Kickjianzi.tscn")

func _on_QuizGame_pressed():
	get_tree().change_scene_to_file("res://scenes/QuizGame.tscn")

func _on_FiveStone_pressed():
	get_tree().change_scene_to_file("res://scenes/FiveStoneGame.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Interactive.tscn")
