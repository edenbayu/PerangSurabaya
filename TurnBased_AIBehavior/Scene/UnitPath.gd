class_name UnitPath
extends TileMap

@export var grid: Resource
var current_path := PackedVector2Array()
var _pathfinder: Pathfinder

func initialize(walkable_cells: Array) -> void:
	_pathfinder = Pathfinder.new(grid, walkable_cells)

func draw(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cell(0, cell, 1, Vector2i(0,0))

#func test_get_cell_id() -> Array:
	#var cell_start = Vector2(0,0)
	#var cell_end = Vector2(2,2)
	#return _pathfinder.calculate_point_paths(cell_start, cell_end)

#PR NIII
func get_walkable_cells() -> Array:
	var map_rect = Rect2i(grid.start_rect, grid.tilemap_size)
	var vectors_inside :Array = []
	 # Iterate over each point inside the rectangle
	for x in range(map_rect.position.x, map_rect.position.x + map_rect.size.x):
		for y in range(map_rect.position.y, map_rect.position.y + map_rect.size.y):
			vectors_inside.append(Vector2i(x, y))
	return vectors_inside
