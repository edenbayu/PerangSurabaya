extends TileMap

var astarGrid = AStarGrid2D.new()
const main_layer = 1
const main_source = 0
const path_taken_atlas_coords = Vector2i(2, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()

# Setup grid
func setup_grid():
	astarGrid.region = Rect2i(-4, -4, 8, 6)
	astarGrid.cell_size = Vector2i(16, 16)
	astarGrid.update()

# Show path from start to mouse click position
func _input(event):
	if event.is_action_pressed("click"):
		if event.position.x >= 0 and event.position.y >= 0:
			var clicked_pos = local_to_map(event.position)
			var start_pos = Vector2i(0, 0)  # Starting position
			show_path(start_pos, clicked_pos)

# Show path from start to end position
func show_path(start_pos, end_pos):
	var path_taken = astarGrid.get_id_path(start_pos, end_pos)
	for cell in path_taken:
		set_cell(main_layer, cell, main_source, path_taken_atlas_coords)
