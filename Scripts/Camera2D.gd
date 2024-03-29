extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	adjust_camera()

func adjust_camera():
	var maze = get_node("/root/Main/TileMap") as MazeGen
	var tile_size = 64
	var maze_size = Vector2(maze.x_dim + 1, maze.y_dim + 1) * tile_size
	self.zoom =  Vector2(self.get_viewport().size.y, self.get_viewport().size.y) / maze_size
	var center_cell = Vector2(maze.x_dim, maze.y_dim) / 2
	center_cell.y -= 0
	self.global_position = maze.to_global(maze.map_to_local(center_cell))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	adjust_camera()
