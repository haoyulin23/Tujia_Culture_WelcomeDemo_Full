extends RigidBody2D

@export var reset_delay := 2.0
@export var reset_height := 200
@export var initial_x_range := Vector2(300, 900)

var reset_timer: Timer

func _ready():
	reset_timer = Timer.new()
	reset_timer.wait_time = reset_delay
	reset_timer.one_shot = true
	reset_timer.connect("timeout", Callable(self, "_on_reset_timer_timeout"))
	add_child(reset_timer)

func _physics_process(delta):
	if position.y > 650 and reset_timer.is_stopped():
		visible = false
		reset_timer.start()

func bounce():
	linear_velocity = Vector2(randf_range(-50, 50), -600)

func _on_reset_timer_timeout():
	var x = randf_range(initial_x_range.x, initial_x_range.y)
	position = Vector2(x, -reset_height)
	linear_velocity = Vector2(0, 50)
	angular_velocity = 0
	visible = true
	sleeping = false

func reset_position():
	# 设置随机初始位置（上方）
	position = Vector2(randi_range(initial_x_range.x, initial_x_range.y), -100)

	# 重置速度
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

	# 唤醒物理
	sleeping = false  # 必须先唤醒，才能应用力
	visible = true

	# 手动施加一个微弱向下的力
	apply_central_impulse(Vector2(0, 50))  # X轴不动，Y轴给一个“向下”的推力
	
	print("毽子已重置，当前位置：", position, ", 当前速度：", linear_velocity)
