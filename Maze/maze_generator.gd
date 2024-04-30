extends Node

@export var width: int = 100
@export var height: int = 100
@export var start_x: int = 5
@export var start_y: int = 5

var maze_data: Array[int] = []
var directions: Array[int] = [0, 1, 2, 3]


func _ready() -> void:
	init()
	generate_maze()


func init() -> void:
	maze_data.clear()
	maze_data.resize(width * height)
	maze_data.fill(1)


func maze_set(x: int, y: int, value: int) -> void:
	maze_data[x + y * width] = value


func maze_get(x: int, y: int) -> int:
	return maze_data[x + y * width]


func generate_maze() -> void:
	var next_cell: Variant = Vector2i(start_x, start_y)
	while true:
		next_cell = carve_cell(next_cell.x, next_cell.y)
		if not next_cell:
			break


func carve_cell(x: int, y: int) -> Variant:
	directions.shuffle()

	for direction in directions:
		match direction:
			0: # Up
				if (x + 2 >= width - 1 || maze_get(x + 2, y) == 0):
					continue

				maze_set(x + 2, y, 0)
				maze_set(x + 1, y, 0)
				return Vector2i(x + 2, y)

			1: # Right
				if (y + 2 >= height - 1 || maze_get(x, y + 2) == 0):
					continue

				maze_set(x, y + 2, 0)
				maze_set(x, y + 1, 0)
				return Vector2i(x, y + 2)

			2: # Down
				if (x - 2 <= 0 || maze_get(x - 2, y) == 0):
					continue

				maze_set(x - 2, y, 0)
				maze_set(x - 1, y, 0)
				return Vector2i(x - 2, y)

			3: # Left
				if (y - 2 <= 0 || maze_get(x, y - 2) == 0):
					continue

				maze_set(x, y - 2, 0)
				maze_set(x, y - 1, 0)
				return Vector2i(x, y - 2)

	return null
