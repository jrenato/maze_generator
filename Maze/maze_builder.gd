extends Node

@export_group("Maze Patterns")
@export var crossroad: MazePattern

@export var dead_end_down: MazePattern
@export var dead_end_up: MazePattern
@export var dead_end_left: MazePattern
@export var dead_end_right: MazePattern

@export var horizontal_straight: MazePattern
@export var vertical_straight: MazePattern

@export var turn_left_down: MazePattern
@export var turn_left_up: MazePattern
@export var turn_right_down: MazePattern
@export var turn_right_up: MazePattern

@export var t_junction_down: MazePattern
@export var t_junction_up: MazePattern
@export var t_junction_left: MazePattern
@export var t_junction_right: MazePattern


@export_group("Maze Properties")
@export var width: int = 100
@export var height: int = 100
@export var start_x: int = 5
@export var start_y: int = 5

@onready var layout_generator: LayoutGenerator = %LayoutGenerator


func _ready() -> void:
	layout_generator.generate_layout(width, height, start_x, start_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
