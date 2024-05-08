@tool
class_name Unit
extends CharacterBody2D

## Emitted when the unit reached the end of a path along which it was walking.
signal walk_finished

@onready var _sprite = $Sprite2D

## Coordinates of the current cell the cursor moved to.
var cell := Vector2.ZERO:
	set(value):
		cell = value

@export var skin: Texture:
	set(value):
		skin = value
		if not _sprite:
			await ready
		_sprite.texture = value
#setter getter

@export var move_range := 4
@export var move_speed := 5

var is_selected := false:
	set(value):
		is_selected = value
		if is_selected:
			pass
		else:
			pass

var _is_walking := false:
	set(value):
		_is_walking = value
		set_process(_is_walking)

func walk(paths: Array, new_cell: Vector2):
	if paths.is_empty():
		_is_walking = false
		return
	cell = new_cell
	for path in paths:
		position = position.move_toward(path, move_speed)

func _process(delta: float):
	#Modulasi jika selected  / not selected
	if not is_selected:
		_sprite.modulate = Color(0.70, 0.70, 0.70)
	else:
		_sprite.modulate = Color(1, 1, 1)
