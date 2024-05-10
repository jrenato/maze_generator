extends Node

@export var layout_generator: LayoutGenerator

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

func match_pattern(x: int, y: int) -> Variant:
	# Straight
	if   (is_pattern_matching(x, y, horizontal_straight_pattern)):
		#place_piece(x, y, 90.0, straight_pieces)
		return {
			"yaw": 90.0, "type": MazePiece.TYPE.STRAIGHT,
			"orientation": MazePiece.ORIENTATION.HORIZONTAL
		}
	elif (is_pattern_matching(x, y, vertical_straight_pattern)):
		#place_piece(x, y, 0.0, straight_pieces)
		return {
			"yaw": 0.0, "type": MazePiece.TYPE.STRAIGHT,
			"orientation": MazePiece.ORIENTATION.VERTICAL
		}

	# Turns
	elif (is_pattern_matching(x, y, turn_left_up_pattern)):
		#place_piece(x, y, 0.0, turn_pieces)
		return {
			"yaw": 0.0, "type": MazePiece.TYPE.TURN,
			"orientation": MazePiece.ORIENTATION.LEFT_UP
		}
	elif (is_pattern_matching(x, y, turn_left_down_pattern)):
		#place_piece(x, y, 90.0, turn_pieces)
		return {
			"yaw": 90.0, "type": MazePiece.TYPE.TURN,
			"orientation": MazePiece.ORIENTATION.LEFT_DOWN
		}
	elif (is_pattern_matching(x, y, turn_right_up_pattern)):
		#place_piece(x, y, -90.0, turn_pieces)
		return {
			"yaw": -90.0, "type": MazePiece.TYPE.TURN,
			"orientation": MazePiece.ORIENTATION.RIGHT_UP
		}
	elif (is_pattern_matching(x, y, turn_right_down_pattern)):
		#place_piece(x, y, 180.0, turn_pieces)
		return {
			"yaw": 180.0, "type": MazePiece.TYPE.TURN,
			"orientation": MazePiece.ORIENTATION.RIGHT_DOWN
		}

	# T Junctions	
	elif (is_pattern_matching(x, y, t_junction_up_pattern)):
		#place_piece(x, y, -90.0, t_junction_pieces)
		return {
			"yaw": -90.0, "type": MazePiece.TYPE.T_JUNCTION,
			"orientation": MazePiece.ORIENTATION.UP
		}
	elif (is_pattern_matching(x, y, t_junction_down_pattern)):
		#place_piece(x, y, 90.0, t_junction_pieces)
		return {
			"yaw": 90.0, "type": MazePiece.TYPE.T_JUNCTION,
			"orientation": MazePiece.ORIENTATION.DOWN
		}
	elif (is_pattern_matching(x, y, t_junction_left_pattern)):
		#place_piece(x, y, 0.0, t_junction_pieces)
		return {
			"yaw": 0.0, "type": MazePiece.TYPE.T_JUNCTION,
			"orientation": MazePiece.ORIENTATION.LEFT
		}
	elif (is_pattern_matching(x, y, t_junction_right_pattern)):
		#place_piece(x, y, 180.0, t_junction_pieces)
		return {
			"yaw": 180.0, "type": MazePiece.TYPE.T_JUNCTION,
			"orientation": MazePiece.ORIENTATION.RIGHT
		}

	# Dead ends
	elif (is_pattern_matching(x, y, dead_end_up_pattern)):
		#place_piece(x, y, 90.0, dead_end_pieces)
		return {
			"yaw": 90.0, "type": MazePiece.TYPE.DEAD_END,
			"orientation": MazePiece.ORIENTATION.UP
		}
	elif (is_pattern_matching(x, y, dead_end_down_pattern)):
		#place_piece(x, y, -90.0, dead_end_pieces)
		return {
			"yaw": -90.0, "type": MazePiece.TYPE.DEAD_END,
			"orientation": MazePiece.ORIENTATION.DOWN
		}
	elif (is_pattern_matching(x, y, dead_end_left_pattern)):
		#place_piece(x, y, 180.0, dead_end_pieces)
		return {
			"yaw": 180.0, "type": MazePiece.TYPE.DEAD_END,
			"orientation": MazePiece.ORIENTATION.LEFT
		}
	elif (is_pattern_matching(x, y, dead_end_right_pattern)):
		#place_piece(x, y, 0.0, dead_end_pieces)
		return {
			"yaw": 0.0, "type": MazePiece.TYPE.DEAD_END,
			"orientation": MazePiece.ORIENTATION.RIGHT
		}

	# Crossroad
	elif (is_pattern_matching(x, y, crossroad_pattern)):
		#place_piece(x, y, 0.0, crossroad_pieces.pick_random())
		return {
			"yaw": 0.0, "type": MazePiece.TYPE.CROSSROAD,
			"orientation": null
		}

	return null


func is_pattern_matching(x: int, y: int, pattern: Array[int]) -> bool:
	var count: int = 0
	var i: int = 0
	for cell_y in range(1, -2, -1):
		for cell_x in range(-1, 2):
			var cell_value: int = layout_generator.layout_get(x + cell_y, y + cell_x)
			if pattern[i] == cell_value or pattern[i] == 5:
				count += 1
			i += 1

	return count == 9;
