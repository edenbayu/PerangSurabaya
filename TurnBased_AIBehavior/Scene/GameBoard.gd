class_name GameBoard
extends Node2D

@onready var unitPath: UnitPath = $UnitPath
@onready var cursor = $Cursor

var is_within_map: bool

##Function untuk mengecek apakah cursor berada di dalam cell yang aktif
func _check_hoverable_tiles(cell: Vector2) -> void:
	var current_cursor_location: Vector2 = unitPath.local_to_map(cell)
	if unitPath.local_to_map(cell) in unitPath.get_walkable_cells():
		cursor._sprite.visible = true
		cursor.position = unitPath.map_to_local(current_cursor_location)
	elif !unitPath.local_to_map(cell) in unitPath.get_walkable_cells():
		cursor._sprite.visible = false
	is_within_map = cursor._sprite.visible 

##Function yang terhubung dengan cursor click
func _select_unit(cell: Vector2) -> void:
	var mapped_pos = unitPath.local_to_map(cell)
	unitPath.draw(Vector2(0,0), mapped_pos)
