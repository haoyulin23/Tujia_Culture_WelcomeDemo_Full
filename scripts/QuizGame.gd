extends CanvasLayer

# 🧩 Riddle data
var riddles = [
	{
		"question": "I tell a story with thread and color.\nYou wear me, but I’m also art.\nWhat am I?",
		"options": [
			"Painting",
			"Traditional embroidered clothing",
			"Dance costume",
			"Silk paper"
		],
		"answer": "Traditional embroidered clothing"
	},
	{
		"question": "Many people move their hands and feet,\ntelling stories without speaking.\nIt happens in festivals and ceremonies.\nWhat is it?",
		"options": [
			"Baishou Dance",
			"Marching",
			"Martial arts",
			"Singing performance"
		],
		"answer": "Baishou Dance"
	},
	{
		"question": "I am not in Spain,\nbut I happen in the mountains.\nTwo strong animals push and fight,\nwhile people cheer loudly.\nWhat am I?",
		"options": [
			"Goat racing",
			"Wrestling",
			"Tujia bullfighting",
			"Mountain running"
		],
		"answer": "Tujia bullfighting"
	},
	{
		"question": "I am a day to honor animals that help in the fields.\nPeople offer food and dance to thank me.\nWhat festival am I?",
		"options": [
			"Spring Festival",
			"Dragon Boat Festival",
			"King of the Cattle Festival",
			"Lantern Festival"
		],
		"answer": "King of the Cattle Festival"
	},
	{
		"question": "I use fire, food, and sometimes dance\nto show respect to nature and the ancestors.\nWhat is this tradition?",
		"options": [
			"Birthday party",
			"Religious lecture",
			"Tujia ritual ceremony",
			"Talent show"
		],
		"answer": "Tujia ritual ceremony"
	}
]

var current_index = 0
var current_riddle = {}

@onready var question_label = $Label
@onready var option_buttons = $VBoxContainer.get_children()
@onready var feedback_label = $FeedbackLabel
@onready var next_button = $NextButton

func _ready():
	next_button.pressed.connect(_on_NextButton_pressed)
	load_riddle()

func load_riddle():
	feedback_label.text = ""
	next_button.visible = false
	current_riddle = riddles[current_index]
	question_label.text = current_riddle["question"]
	var options = current_riddle["options"]

	for i in range(option_buttons.size()):
		var button = option_buttons[i]
		var option_text = options[i]
		button.text = option_text
		button.disabled = false

		# 断开旧连接，防止重复触发
		if button.pressed.is_connected(_on_option_pressed):
			button.pressed.disconnect(_on_option_pressed)

		# 连接新的带参数函数
		button.pressed.connect(func():
			_on_option_pressed(option_text)
		)

func _on_option_pressed(option_text):
	for button in option_buttons:
		button.disabled = true

	if option_text == current_riddle["answer"]:
		feedback_label.text = "✅ Correct!"
	else:
		feedback_label.text = "❌ Wrong! The correct answer is: " + current_riddle["answer"]

	next_button.visible = true

func _on_NextButton_pressed():
	current_index += 1
	if current_index >= riddles.size():
		question_label.text = "🎉 Congratulations! You've completed all riddles!"
		for button in option_buttons:
			button.hide()
		next_button.hide()
		feedback_label.text = ""
	else:
		load_riddle()
		
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSelect.tscn")
