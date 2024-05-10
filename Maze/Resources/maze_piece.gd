class_name MazePiece extends Resource

enum TYPE {CROSSROAD, DEAD_END, STRAIGHT, T_JUNCTION, TURN}
enum ORIENTATION {HORIZONTAL, VERTICAL, UP, DOWN, LEFT, RIGHT,
						LEFT_UP, LEFT_DOWN, RIGHT_UP, RIGHT_DOWN}

@export var type: TYPE
@export var orientation: ORIENTATION
@export var piece_yaw: float = 0
@export var piece_scene: PackedScene
