class_name UnitPath
extends TileMap

@export var grid: Resource
var current_path := PackedVector2Array()
var _pathfinder: Pathfinder

func initialize(walkable_cells: Array) -> void:
	_pathfinder = Pathfinder.new(grid, walkable_cells)

func draw(cell_start: Vector2, cell_end: Vector2) -> void:
	current_path = _pathfinder.calculate_point_path(cell_start, cell_end)
	for cell in current_path:
		set_cell(0, cell, 0, Vector2(3,0))
	print(current_path)
