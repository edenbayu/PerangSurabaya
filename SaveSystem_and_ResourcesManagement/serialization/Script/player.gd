class_name Player extends CharacterBody2D

## Password and file path to save the data 
var m_Password = "123456"
var m_GameStateFile = "res://savedgame1.sav"

## Movement speed in pixels per second.
const MOVEMENT_SPEED = 240.0

var health := 100.0:
	get:
		return health
	set(value):
		health = value
		progress_bar.value = value
		if health <= 0.0:
			# The player died.
			get_tree().reload_current_scene()
var motion := Vector2()

@onready var progress_bar := $ProgressBar as ProgressBar
@onready var sprite := $Sprite2D as Sprite2D
@onready var loadbutton := $"../../Control/LoadTest"

## Serialize the object's properties
func Serialize(file : FileAccess) -> void:
	file.store_float(health)
	file.store_float(rotation)

## Read the object's properties from the file and deserialize it
func Deserialize(file : FileAccess) -> void:
	health = file.get_float()
	rotation = file.get_float()


func _process(_delta: float):
	velocity = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	if velocity.length_squared() > 1.0:
		velocity = velocity.normalized()
	velocity *= MOVEMENT_SPEED
	move_and_slide()

func _input(event: InputEvent):
	if event.is_action_pressed(&"move_left"):
		sprite.rotation = PI / 2
	elif event.is_action_pressed(&"move_right"):
		sprite.rotation = -PI / 2
	elif event.is_action_pressed(&"move_up"):
		sprite.rotation = PI
	elif event.is_action_pressed(&"move_down"):
		sprite.rotation = 0.0

## Initialize the game path file and password
func _ready() -> void:
	SaveLoadModule.Initialize(m_GameStateFile, m_Password)

## Node is destroyed when exited
func _exit_tree() -> void:
	SaveLoadModule.Clear()

func _IsHealthEmpty() -> bool:
	return (health == null)

# Save the object's properties to the file
func _OnButtonSaveGamePressed():
	if (not _IsHealthEmpty()):	# Verify all user interface fields have values
		
		var status = SaveLoadModule.OpenFile(FileAccess.WRITE)	# Open the file with a write access
		if (status != OK):	
			print("Unable to open the file %s. Received error: %d" % [m_GameStateFile, status])
			return
			
		SaveLoadModule.Serialize(self)				# Write the object's properties into the file
		SaveLoadModule.CloseFile()					# Close the file
		
		loadbutton.disabled = false

# Load the object's properties from the file
func _OnButtonLoadGamePressed():
	var status = SaveLoadModule.OpenFile(FileAccess.READ)	# Open the file with a read access
	if (status != OK):
		print("Unable to open the file %s. Received error: %d" % [m_GameStateFile, status])
		return
	
	SaveLoadModule.Deserialize(self)			# Read data from the file and update the object's properties
	SaveLoadModule.CloseFile()					# Close the file
