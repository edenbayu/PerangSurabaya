extends Button

@export var game_node: NodePath
@onready var player_node: CharacterBody2D = $"../../CharacterBody2D"

# const SAVE_PATH = "D:\\Undip\\Semester8 (Tugas Akhir)\\tesjson"
const SAVE_PATH = "res://tesjson.json"

func load_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary
	
	var player := player_node
	# JSON doesn't support many of Godot's types such as Vector2.w
	# str_to_var can be used to convert a String to the corresponding Variant.
	player.position = str_to_var(save_dict.player.position)

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var player := player_node
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict = {
		player = {
			position = var_to_str(player.position),
			rotation = var_to_str(player.sprite.rotation)
		}
	}

	file.store_line(JSON.stringify(save_dict))

	get_node(^"../LoadButton").disabled = false

func _ready(): 
	load_game()
