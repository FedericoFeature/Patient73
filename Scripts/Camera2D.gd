extends Camera2D

@onready var tilemap: TileMap = get_node("/root/Main/TileMap")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	adjust_camera()
	set_anchor_mode(Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT)
	var zoom_vector = get_camera_zoom_to_tilemap()
	#print(zoom_vector)
	set_zoom(zoom_vector)
	print(position)
	position = Vector2(position.x -
	((Globals.grid_size / 3.71) * tilemap.get_tileset().tile_size.x) - (
		tilemap.get_tileset().tile_size.x / 8),
		position.y -(tilemap.get_tileset().tile_size.x) * 0.75)

func _physics_process(delta):
	var tm_pos = tilemap.get_used_rect().position
	#print(tm_pos)

func adjust_camera():
	pass
	#var maze = get_node("/root/Main/TileMap") as MazeGen
	#var tile_size = 64
	#var maze_size = Vector2(maze.x_dim + 1, maze.y_dim + 1) * tile_size
	#self.zoom =  Vector2(self.get_viewport().size.y, self.get_viewport().size.y) / maze_size
	#var center_cell = Vector2(maze.x_dim, maze.y_dim) / 2
	#center_cell.y -= 0
	#self.global_position = maze.to_global(maze.map_to_local(center_cell))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	adjust_camera()

func get_camera_zoom_to_tilemap():
	
	var zoom_vector: Vector2 = Vector2.ZERO
	var viewport_size = get_viewport().size # [x, y]
	var tilemap_info = get_tilemap_info()
	var level_size = Vector2i(tilemap_info.tile_size * tilemap_info.size)
	var viewport_aspect = float(viewport_size[0]) / float(viewport_size[1])
	var level_aspect = float(level_size.x) / float(level_size.y)
	
	var new_zoom = 1.0
	
	if(level_aspect > viewport_aspect):
		new_zoom = float(viewport_size[1]) / float(level_size.y)
	else:
		new_zoom = float(viewport_size[0]) / float(level_size.x)
	#print(viewport_aspect)
	#print(level_aspect)
	#print(new_zoom)
	
	return Vector2(new_zoom, new_zoom)
	
	
	
	return zoom_vector

func get_tilemap_info():
	var tile_size = tilemap.get_tileset().tile_size
	var tilemap_rect = Vector2(Globals.grid_size + 2, Globals.grid_size + 2)

	var tilemap_size = Vector2i(
		tilemap_rect.x - 3,
		tilemap_rect.y - 5
	)
	return {"size": tilemap_size, "tile_size": tile_size}
