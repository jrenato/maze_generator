extends Node3D

const CROSSROAD_PIECE: int = 	0
const DEAD_END_PIECE: int = 	1
const STRAIGHT_PIECE: int = 	2
const T_JUNCTION_PIECE: int = 	3
const TURN_PIECE: int = 		4

@export var player_scene: PackedScene

# Straight -- 5s are wildcards --
var horizontal_straight_pattern: Array[int] = [ 5, 1, 5,
 												0, 0, 0,
 												5, 1, 5 ]

var vertical_straight_pattern: Array[int] = [   5, 0, 5,
												1, 0, 1,
												5, 0, 5 ]

# TJunctions	
var t_junction_up_pattern: Array[int] = [   1, 0, 1,
											0, 0, 0,
											5, 1, 5 ]

var t_junction_down_pattern: Array[int] = [ 5, 1, 5,
											0, 0, 0,
											1, 0, 1 ]

var t_junction_left_pattern: Array[int] = [ 1, 0, 5,
 											0, 0, 1,
 											1, 0, 5 ]

var t_junction_right_pattern: Array[int] = [5, 0, 1,
 											1, 0, 0,
 											5, 0, 1 ]

# Crossroad
var crossroad_pattern: Array[int] = [   1, 0, 1,
										0, 0, 0,
										1, 0, 1 ]

# Turns
var turn_left_up_pattern: Array[int] = [1, 0, 5,
										0, 0, 1,
										5, 1, 5 ]

var turn_left_down_pattern: Array[int] = [  5, 1, 5,
											0, 0, 1,
											1, 0, 5 ]

var turn_right_up_pattern: Array[int] = [   5, 0, 1,
											1, 0, 0,
											5, 1, 5 ]

var turn_right_down_pattern: Array[int] = [ 5, 1, 5,
											1, 0, 0,
											5, 0, 1 ]

# Dead ends
var dead_end_up_pattern: Array[int] = [ 5, 0, 5,
										1, 0, 1,
										5, 1, 5 ]

var dead_end_down_pattern: Array[int] = [   5, 1, 5,
											1, 0, 1,
											5, 0, 5 ]

var dead_end_left_pattern: Array[int] = [   5, 1, 5,
											0, 0, 1,
											5, 1, 5 ]

var dead_end_right_pattern: Array[int] = [  5, 1, 5,
											1, 0, 0,
											5, 1, 5 ]

@onready var grid_map: GridMap = %GridMap
@onready var maze_generator: Node = %MazeGenerator


func _ready() -> void:
	maze_generator.maze_generated.connect(draw_maze)
	maze_generator.generate_maze()
	spawn_player()

	# TODO: Why this isn't working?
	print(get_tree().get_nodes_in_group("spawn_points").size())


func draw_maze() -> void:
	grid_map.clear()

	for x in range(maze_generator.width - 1):
		for y in range(maze_generator.height - 1):
			# Straight
			if   (is_pattern_matching(x, y, horizontal_straight_pattern)): place_piece(x, y, 90.0, STRAIGHT_PIECE)
			elif (is_pattern_matching(x, y, vertical_straight_pattern)): place_piece(x, y, 0.0, STRAIGHT_PIECE)

			# Turns
			elif (is_pattern_matching(x, y, turn_left_up_pattern)): place_piece(x, y, 0.0, TURN_PIECE)
			elif (is_pattern_matching(x, y, turn_left_down_pattern)): place_piece(x, y, 90.0, TURN_PIECE)
			elif (is_pattern_matching(x, y, turn_right_up_pattern)): place_piece(x, y, -90.0, TURN_PIECE)
			elif (is_pattern_matching(x, y, turn_right_down_pattern)): place_piece(x, y, 180.0, TURN_PIECE)

			# T Junctions	
			elif (is_pattern_matching(x, y, t_junction_up_pattern)): place_piece(x, y, -90.0, T_JUNCTION_PIECE)
			elif (is_pattern_matching(x, y, t_junction_down_pattern)): place_piece(x, y, 90.0, T_JUNCTION_PIECE)
			elif (is_pattern_matching(x, y, t_junction_left_pattern)): place_piece(x, y, 0.0, T_JUNCTION_PIECE)
			elif (is_pattern_matching(x, y, t_junction_right_pattern)): place_piece(x, y, 180.0, T_JUNCTION_PIECE)

			# Dead ends
			elif (is_pattern_matching(x, y, dead_end_up_pattern)): place_piece(x, y, 90.0, DEAD_END_PIECE)
			elif (is_pattern_matching(x, y, dead_end_down_pattern)): place_piece(x, y, -90.0, DEAD_END_PIECE)
			elif (is_pattern_matching(x, y, dead_end_left_pattern)): place_piece(x, y, 180.0, DEAD_END_PIECE)
			elif (is_pattern_matching(x, y, dead_end_right_pattern)): place_piece(x, y, 0.0, DEAD_END_PIECE)

			# Crossroad
			elif (is_pattern_matching(x, y, crossroad_pattern)): place_piece(x, y, 0.0, CROSSROAD_PIECE)


func is_pattern_matching(x: int, y: int, pattern: Array[int]) -> bool:
	var count: int = 0
	var i: int = 0
	for cell_y in range(1, -2, -1):
		for cell_x in range(-1, 2):
			var cell_value: int = maze_generator.maze_get(x + cell_y, y + cell_x)
			if pattern[i] == cell_value or pattern[i] == 5:
				count += 1
			i += 1

	return count == 9;


func place_piece(x: int, y: int, yaw: float, piece_index: int) -> void:
	var maze_scale: int = 2

	# TODO: Instead of this, update the yaws on draw_maze()
	# Another possibility is changing the yaws on Blender
	yaw -= 90.0
	match piece_index:
		TURN_PIECE:
			yaw -= 90.0


	var piece_position: Vector3i = Vector3i(x * maze_scale, 0, y * maze_scale)
	var basis_rotated: Basis = Basis.IDENTITY.rotated(Vector3.UP, deg_to_rad(yaw))
	var rotation_index: int = grid_map.get_orthogonal_index_from_basis(basis_rotated)

	grid_map.set_cell_item(piece_position, piece_index, rotation_index)


func spawn_player() -> void:
	var player: Player = player_scene.instantiate()
	add_child(player)

	var used_cells: Array[Vector3i] = grid_map.get_used_cells()
	var used_cell: Vector3i = used_cells.pick_random()
	player.position = grid_map.map_to_local(used_cell)
