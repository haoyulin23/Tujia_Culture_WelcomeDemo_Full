extends RigidBody2D

var _need_reset := false
var _reset_pos := Vector2.ZERO
var score = 0

@export var scoreLabel:Label

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	var screen_width: float = get_viewport_rect().size.x
	var random_x: float = randf_range(0, screen_width)
	_need_reset = true
	_reset_pos = Vector2(random_x, -600)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if _need_reset:
		state.transform.origin = _reset_pos
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		_need_reset = false

func  addScore():
	updateScore(score+1)

func updateScore(newScore: int):
	score = newScore
	scoreLabel.text = "score: "+str(newScore)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("ground"): # 给地面加到 "ground" 组
		updateScore(0)
