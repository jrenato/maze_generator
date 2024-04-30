extends Node3D

@export var left_basis: Basis = Basis(Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1))
@export var right_basis: Basis = Basis(Vector3(-1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, -1))
@export var down_basis: Basis = Basis(Vector3(0, 0, -1), Vector3(0, 1, 0), Vector3(1, 0, 0))
@export var up_basis: Basis = Basis(Vector3(0, 0, 1), Vector3(0, 1, 0), Vector3(-1, 0, 0))

@onready var grid_map: GridMap = %GridMap


func _ready() -> void:
	grid_map.clear()
	grid_map.set_cell_item(Vector3i(0, 0, 0), 0)

	var piece_index: int = 1

	grid_map.set_cell_item(Vector3i(-2, 0, 0), piece_index, 0) # Left
	grid_map.set_cell_item(Vector3i(2, 0, 0), piece_index, 10) # Right
	grid_map.set_cell_item(Vector3i(0, 0, 2), piece_index, 16) # Down
	grid_map.set_cell_item(Vector3i(0, 0, -2), piece_index, 22) # Up
