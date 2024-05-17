extends Button

@onready var button = $"."
const SAVE_PATH = "res://script//save_test.json"

func load_array():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	var value = json.parse_string(file.get_as_text())
	
	# button.text = 
	return value
