extends Node2D

@onready var tile_map: TileMap = %TileMap


func _ready() -> void:
	var first_cell: Vector2i = Vector2i(0, 0)
	tile_map.set_cell(0, first_cell, 0, Vector2i(1, 0))
