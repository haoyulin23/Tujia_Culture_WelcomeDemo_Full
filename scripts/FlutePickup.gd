extends Area2D

func _ready():
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("🎵 笛子被点击，放入背包")
		InventoryPanel.m_to_slot("flute")
		queue_free()
