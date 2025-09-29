extends Node


func _ready():
	Global.slots = []
	for child in get_children():
		if child.name.begins_with("Slot"):
			Global.slots.append(child)
	print("✅ 初始化 slot 数量：", Global.slots.size())

# 存储已放入的 item texture 引用
var inventory_items: Array[Texture2D] = []

# 添加物品到空 Slot 中
func add_item_to_inventory(item_texture: Texture2D):
	for i in range(Global.slots.size()):
		if Global.slots[i].texture == null:  # 空 slot
			Global.slots[i].texture = item_texture
			inventory_items.append(item_texture)
			return

# 可选：清空所有 slot
func clear_inventory():
	for i in range(Global.slots.size()):
		Global.slots[i].texture = preload("res://assets/inventory_slot.png")
	inventory_items.clear()

# 可选：检查是否已添加过此 item
func has_item(item_texture: Texture2D) -> bool:
	return item_texture in inventory_items

	for i in range(Global.slots.size()):
		Global.slots[i].texture = preload("res://assets/inventory_slot.png")
	inventory_items.clear()
	
func m_to_slot(item_name: String):
	print(0, item_name)
	print(Global.slots)
	for slot in Global.slots:
		print(1, item_name)
		if slot.name.begins_with("Slot") and slot.get_child_count() == 0:
			var item_scene = load("res://items/Item_%s.tscn" % item_name.capitalize())
			var item = item_scene.instantiate()
			slot.add_child(item)
			return
		print("📦 尝试添加物品：", item_name)
	var slot_found = false

	for slot in Global.slots:
		print(2, item_name)
		if slot.name.begins_with("Slot") and slot.get_child_count() == 0:
			print("🟨 找到空 slot：", slot.name)
			
			var item_path = "res://items/Item_%s.tscn" % item_name.capitalize()
			print("📁 加载预制体路径：", item_path)

			if ResourceLoader.exists(item_path):
				var item_scene = load(item_path)
				var item = item_scene.instantiate()
				slot.add_child(item)
				print("✅ 添加成功到 slot")
			else:
				print("❌ 预制体不存在，请确认路径！")
			
			slot_found = true
			break

	if not slot_found:
		print("⚠️ 没有找到空 slot 或加载失败")
