class_name Pathfinder
extends Resource

var _grid: Resource
var _astar := AStarGrid2D.new()

##Init untuk AstartGrid2D's Grid
func _init(grid: Grid, walkable_cells: Array) -> void:
	_grid = grid
	_astar.size = _grid.size
	_astar.cell_size = _grid.cell_size
	_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.update()
	
	##Iterasi untuk seluruh points dalam grid yang bukan termasuk walkable
	for y in _grid.size.y:
		for x in _grid.size.x:
			if not walkable_cells.has(Vector2(x,y)):
				_astar.set_point_solid(Vector2(x,y))

func calculate_point_paths(start: Vector2, end: Vector2)-> PackedVector2Array:
	return _astar.get_id_path(start, end)
