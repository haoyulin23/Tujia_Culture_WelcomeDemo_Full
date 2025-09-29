extends Area2D

func _ready():
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("🥁 鼓被点击，放入背包")
		InventoryPanel.m_to_slot("drum")  # 调用背包脚本添加物品
		queue_free()  # 鼓消失
