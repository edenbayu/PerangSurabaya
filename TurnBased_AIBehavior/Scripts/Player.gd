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
@export var move_speed := 500

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

func walk(paths: Array):
	if paths.is_empty():
		_is_walking = false
		return
	else:
		paths.pop_front()
		_is_walking = true
	var target_pos = paths.front()
	global_position = global_position.move_toward(target_pos, move_speed)
	if global_position == target_pos:
		paths.pop_front()
	#_is_walking = true
	#print(paths)
	#while _is_walking:
		#var target_pos = paths.front()
		#paths.pop_front()
		#global_position = global_position.move_toward(target_pos, move_speed)


func _process(delta: float):
	pass
