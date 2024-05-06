extends Button

@onready var button = $"."
const SAVE_PATH = "res://script//save_test.json"


func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var time = Time.get_datetime_dict_from_system()
	
	var save_dict = {
		stat = {
			time = time
		}
	}
	
	# print(f"coba {time}")
	
	button.text = "Save Game" + "\n" + "Date: " + str("%02d-%02d-%04d" % [time.day, time.month, time.year]) + "\n" + "Time: " + str("%02d:%02d:%02d" % [time.hour, time.minute, time.second])
	
	file.store_string(JSON.stringify(save_dict))
	file.close()
	file = null
	
	get_node(^"../Load").disabled = false
	# button.text = time


func load_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	var value = json.parse_string(file.get_as_text())
	
	# button.text = 
	return value
