class_name GameBoard
extends Node2D

@onready var unitPath = $UnitPath
@onready var cursor = $Cursor

func _check_hoverable_tiles():
	if unitPath.local_to_map(position) in unitPath.get_walkable_cells():
		_sprite.visible = true
	elif !unitPath.local_to_map(position) in unitPath.get_walkable_cells():
		_sprite.visible = false
	is_within_map = _sprite.visible
