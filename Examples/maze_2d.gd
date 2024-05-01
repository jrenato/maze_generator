extends Node2D

@export var floor_tile: Vector2i = Vector2i(0, 4)
@export var wall_tile: Vector2i = Vector2i(4, 3)

@onready var maze_generator: Node = %MazeGenerator
@onready var tile_map: TileMap = %TileMap


func _ready() -> void:
	maze_generator.maze_generated.connect(_on_maze_generated)
	maze_generator.generate_maze()


func fill_tile_map() -> void:
	tile_map.clear()
	for x in range(maze_generator.width - 1):
		for y in range(maze_generator.height - 1):
			set_cell(x, y, maze_generator.maze_get(x, y))


func set_cell(x: int, y: int, value: int) -> void:
	if value == 0:
		tile_map.set_cell(0, Vector2i(x, y), 0, floor_tile)
	else:
		tile_map.set_cell(0, Vector2i(x, y), 0, wall_tile)


func _on_maze_generated() -> void:
	fill_tile_map()
