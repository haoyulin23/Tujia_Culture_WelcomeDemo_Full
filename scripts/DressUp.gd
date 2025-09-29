extends Node2D

@onready var top_layer = $TopLayer
@onready var skirt_layer = $SkirtLayer
@onready var headpiece_layer = $HeadpieceLayer
@onready var necklace_layer = $NecklaceLayer
@onready var earring_layer = $EarringLayer
@onready var earring_layer2 = $EarringLayer2
@onready var bracelet_layer = $BraceletLayer

@onready var info_image = $InfoPanel/ItemImage
@onready var info_title = $InfoPanel/ItemTitle
@onready var info_desc = $InfoPanel/ItemDescription

# 按钮结构（Button + TextureRect）
@onready var btn_top = $VBoxContainer/LeftPanel/BtnTop
@onready var btn_skirt = $VBoxContainer/LeftPanel/BtnSkirt
@onready var btn_headpiece = $VBoxContainer/LeftPanel/BtnHeadpiece
@onready var btn_necklace = $VBoxContainer/LeftPanel/BtnNecklace
@onready var btn_earring = $RightPanel/BtnEarring
@onready var btn_bracelet = $RightPanel/BtnBracelet

func _ready():
	btn_top.pressed.connect(_on_btn_top_pressed)
	btn_skirt.pressed.connect(_on_btn_skirt_pressed)
	btn_headpiece.pressed.connect(_on_btn_headpiece_pressed)
	btn_necklace.pressed.connect(_on_btn_necklace_pressed)
	btn_earring.pressed.connect(_on_btn_earring_pressed)
	btn_bracelet.pressed.connect(_on_btn_bracelet_pressed)

func _on_btn_top_pressed():
	apply_item("top")

func _on_btn_skirt_pressed():
	apply_item("skirt")

func _on_btn_headpiece_pressed():
	apply_item("headpiece")

func _on_btn_necklace_pressed():
	apply_item("necklace")

func _on_btn_earring_pressed():
	apply_item("earring")

func _on_btn_bracelet_pressed():
	apply_item("bracelet")

func apply_item(item_type: String):
	match item_type:
		"top":
			top_layer.texture = load("res://assets/clothing/top_blue_embroidery.png")
			info_image.texture = load("res://assets/clothing/top_blue_embroidery.png")
			info_title.text = "Festival Blouse"
			info_desc.text = "This embroidered blouse is worn during festivals and symbolizes harmony."
		"skirt":
			skirt_layer.texture = load("res://assets/clothing/skirt_black_redtrim.png")
			info_image.texture = load("res://assets/clothing/skirt_black_redtrim.png")
			info_title.text = "Pleated Skirt"
			info_desc.text = "A traditional pleated skirt with red and orange trim."
		"headpiece":
			headpiece_layer.texture = load("res://assets/accessories/headpiece_silver_phoenix.png")
			info_image.texture = load("res://assets/accessories/headpiece_silver_phoenix.png")
			info_title.text = "Silver Headdress"
			info_desc.text = "Worn by Tujia women, featuring a silver phoenix and intricate patterns."
		"necklace":
			necklace_layer.texture = load("res://assets/accessories/necklace_embroidery.png")
			info_image.texture = load("res://assets/accessories/necklace_embroidery.png")
			info_title.text = "Embroidered Necklace"
			info_desc.text = "A traditional necklace featuring colorful embroidery."
		"earring":
			earring_layer.texture = load("res://assets/accessories/earring_multicolor_tassel.png")
			earring_layer2.texture = load("res://assets/accessories/earring_multicolor_tassel.png")
			info_image.texture = load("res://assets/accessories/earring_multicolor_tassel.png")
			info_title.text = "Festival Earrings"
			info_desc.text = "Colorful tassel earrings worn during special occasions."
		"bracelet":
			bracelet_layer.texture = load("res://assets/accessories/bracelet_silver.png")
			info_image.texture = load("res://assets/accessories/bracelet_silver.png")
			info_title.text = "Silver Bracelet"
			info_desc.text = "A delicate silver bracelet symbolizing elegance and blessings."

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
