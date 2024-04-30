extends Node

signal maze_generated

enum Direction {UP, RIGHT, DOWN, LEFT}

@export var width: int = 100
@export var height: int = 100
@export var start_x: int = 5
@export var start_y: int = 5

var maze_data: Array[int] = []
var directions: Array[int] = [Direction.UP, Direction.RIGHT, Direction.DOWN, Direction.LEFT]
# Remaining cells that may be carved
var cell_cache: Array[Vector2i] = []

func _ready() -> void:
	pass


func maze_init() -> void:
	maze_data.clear()
	maze_data.resize(width * height)
	maze_data.fill(1)


func maze_set(x: int, y: int, value: int) -> void:
	maze_data[x + y * width] = value


func maze_get(x: int, y: int) -> int:
	return maze_data[x + y * width]


func generate_maze() -> void:
	maze_init()

	cell_cache.clear()
	# Adds the starting cell to the cache
	cell_cache.append(Vector2i(start_x, start_y))

	var current_cell: Variant = null
	var carved_cell: Variant = null

	while cell_cache.size() > 0:
		current_cell = cell_cache.back()
		carved_cell = null

		# Returns the Vector2i of the carved cell, or null if dead end
		carved_cell = carve_cell(current_cell.x, current_cell.y)

		if carved_cell:
			# Will try to carve on the carved cell on next loop
			cell_cache.push_back(carved_cell)
		else:
			# Reached a dead end, remove the current cell from cache
			cell_cache.pop_back()

	maze_generated.emit()


func carve_cell(x: int, y: int) -> Variant:
	directions.shuffle()

	for direction in directions:
		match direction:
			Direction.UP:
				if (x + 2 >= width - 1 || maze_get(x + 2, y) == 0):
					continue

				maze_set(x + 2, y, 0)
				maze_set(x + 1, y, 0)
				return Vector2i(x + 2, y)

			Direction.RIGHT:
				if (y + 2 >= height - 1 || maze_get(x, y + 2) == 0):
					continue

				maze_set(x, y + 2, 0)
				maze_set(x, y + 1, 0)
				return Vector2i(x, y + 2)

			Direction.DOWN:
				if (x - 2 <= 0 || maze_get(x - 2, y) == 0):
					continue

				maze_set(x - 2, y, 0)
				maze_set(x - 1, y, 0)
				return Vector2i(x - 2, y)

			Direction.LEFT:
				if (y - 2 <= 0 || maze_get(x, y - 2) == 0):
					continue

				maze_set(x, y - 2, 0)
				maze_set(x, y - 1, 0)
				return Vector2i(x, y - 2)

	return null
