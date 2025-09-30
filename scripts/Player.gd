extends AnimatedSprite2D

@export var move_speed := 300
@export var min_x := 100  # 左边界限制
@export var max_x := 1000  # 右边界限制

var jianzi: RigidBody2D
@export var collisionShape : CollisionShape2D
var px = 0;

func _ready():
	play("idle")
	px = collisionShape.position.x;

func _process(delta):
	var moved
	if Input.is_action_pressed("ui_right"):
		position.x += move_speed * delta
		collisionShape.position.x = px;
		flip_h = true
		moved = true
	elif Input.is_action_pressed("ui_left"):
		position.x -= move_speed * delta
		collisionShape.position.x = -px;
		flip_h = false
		moved = true
	position.x = clamp(position.x, min_x, max_x)
	if moved and animation != "kick":
		play("idle")

func _input(event):	
	if event.is_action_pressed("ui_accept"):
		play("kick")
		if jianzi:
			jianzi.addScore()
			jianzi.apply_central_impulse(Vector2(0, -1600))

func _on_AnimatedSprite2D_animation_finished():
	if animation == "kick":
		play("idle")

func _on_RestartButton_pressed():
	var jianziNode: Node = get_node("/root/KickJianzi/Jianzi")
	if jianziNode:
		jianziNode.reset_position() 


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSelect.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("enter")
	if body is RigidBody2D:
		jianzi = body;


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("exited")
	if body is RigidBody2D:
		jianzi = null;
