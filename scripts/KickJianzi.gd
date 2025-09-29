extends Node2D

@onready var player = $Player
@onready var jianzi = $Jianzi
@onready var score_label = $UI/ScoreLabel
@onready var restart_button = $UI/RestartButton

var score = 0

func _ready():
	restart_button.pressed.connect(_on_restart_button_pressed)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		player.kick()
		if abs(jianzi.global_position.x - player.global_position.x) < 50 and jianzi.global_position.y > player.global_position.y - 30:
			jianzi.bounce()
			score += 1
			score_label.text = "Score: %s" % score

func _process(_delta):
	if jianzi.global_position.y > 700:
		game_over()

func game_over():
	get_tree().paused = true
	restart_button.visible = true

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
