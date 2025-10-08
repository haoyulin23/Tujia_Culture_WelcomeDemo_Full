extends RigidBody2D

var _need_reset := false
var _reset_pos := Vector2.ZERO
var _score: int = 0
var _initPosition : Vector2
@export var scoreLabel:Label

func _ready() -> void:
	_initPosition = position	

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

func reset_position_and_score()->void:
	updateScore(0)
	_reset_pos = _initPosition
	_need_reset = true

func addScore():
	updateScore(_score+1)

func updateScore(newScore: int):
	_score = newScore
	scoreLabel.text = "score: "+str(newScore)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("ground"): # 给地面加到 "ground" 组
		EventBus.call_reset()
