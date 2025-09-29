extends Node

var selected_avatar = ""
var slots: Array

# Global.gd

var unlocked_locations = {
	"Youyang": true,
	"Fenghuang": false
}
func save_progress():
	var save_data = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	save_data.store_var(Global.unlocked_locations)
	save_data.close()

func load_progress():
	if FileAccess.file_exists("user://save_game.dat"):
		var save_data = FileAccess.open("user://save_game.dat", FileAccess.READ)
		Global.unlocked_locations = save_data.get_var()
		save_data.close()
		
var collected_items = {}

func add_item(name: String):
	collected_items[name] = true

func has_item(name: String) -> bool:
	return collected_items.get(name, false)
