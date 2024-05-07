@tool
class_name Unit
extends CharacterBody2D

@onready var _sprite = $Sprite2D

@export var skin: Texture:
	set(value):
		skin = value
		if not _sprite:
			await ready
		_sprite.texture = value
#setter getter

@export var move_range := 4

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
