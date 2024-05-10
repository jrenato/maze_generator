extends Node

@export var width: int = 100
@export var height: int = 100
@export var start_x: int = 5
@export var start_y: int = 5
@export var maze_scale: int = 3
@export var maze_root: Node

@export var crossroad_pieces: Array[MazePiece]
@export var dead_end_pieces: Array[MazePiece]
@export var straight_pieces: Array[MazePiece]
@export var t_junction_pieces: Array[MazePiece]
@export var turn_pieces: Array[MazePiece]

@onready var layout_generator: LayoutGenerator = %LayoutGenerator
@onready var pattern_matcher: Node = $PatternMatcher


func _ready() -> void:
	layout_generator.generate_layout(width, height, start_x, start_y)


func build_maze() -> void:
	for child in maze_root.get_children():
		child.queue_free()

	for x in range(width - 1):
		for y in range(height - 1):
			var piece_data: Dictionary = pattern_matcher.match_pattern(x, y)
			if piece_data:
				place_piece(x, y, piece_data)


func place_piece(x: int, y: int, piece_data: Dictionary) -> void:
	var piece_matched: Dictionary = find_piece(piece_data)
	var yaw: float = piece_matched["yaw"]

	# TODO: Instead of this, update the yaws on draw_maze()
	# Another possibility is changing the yaws on Blender
	# yaw -= 90.0
	# match piece_index:
	# 	TURN_PIECE:
	# 		yaw -= 90.0

	var piece_position: Vector3i = Vector3i(x * maze_scale, 0, y * maze_scale)
	var basis_rotated: Basis = Basis.IDENTITY.rotated(Vector3.UP, deg_to_rad(yaw))
	#var rotation_index: int = grid_map.get_orthogonal_index_from_basis(basis_rotated)

	#maze_root.set_cell_item(piece_position, piece_index, rotation_index)


func find_piece(piece_data: Dictionary) -> Dictionary:
	# Tries to find a piece scene that correspond to the piece
	# data return. Orientation must take priority, if not found
	# return a yaw too to rotate it (it's ugly in 2D)
	var piece_type: String = piece_data["type"]
	var orientation: String = piece_data["orientation"]
	var yaw: float = piece_data["yaw"]

	match piece_type:
		MazePiece.TYPE.STRAIGHT:
			for piece in straight_pieces:
				if piece.orientation == piece_data["orientation"]:
					return {"yaw": 0.0, "scene": piece.piece_scene}
