extends Node2D

@export var player_scene: PackedScene
@export var enemy_scene: PackedScene
@export var chest_scene: PackedScene
@export var door_scene: PackedScene
@export var floor_tile: Vector2i = Vector2i(0, 4)
@export var wall_tile: Vector2i = Vector2i(4, 3)

@export var width: int = 60
@export var height: int = 40
@export var start_x: int = 5
@export var start_y: int = 5

var player: Player2D
var enemy: Enemy2D

var carved_cells: Array[Vector2i]
var furthest_carved_cell: Vector2

@onready var layout_generator: LayoutGenerator = %LayoutGenerator
@onready var tile_map: TileMap = %TileMap


func _ready() -> void:
	layout_generator.layout_generated.connect(_on_layout_generated)
	layout_generator.generate_layout(width, height, start_x, start_y)

	var start_position: Vector2 = Vector2(start_x, start_y)

	for carved_cell in carved_cells:
		var carved_cell_temp: Vector2 = carved_cell

		if not furthest_carved_cell:
			furthest_carved_cell = carved_cell_temp
			continue

		if furthest_carved_cell.distance_to(start_position) < carved_cell_temp.distance_to(start_position):
			furthest_carved_cell = carved_cell_temp

	spawn_object(door_scene, tile_map.map_to_local(furthest_carved_cell))

	start_game()


func start_game() -> void:
	spawn_objects(enemy_scene, 4)
	spawn_objects(chest_scene, 4)
	spawn_player()


func spawn_objects(object_scene: PackedScene, amount: int = 1) -> void:
	for i in range(amount):
		var random_carved_cell: Vector2i = carved_cells.pick_random()
		var random_position: Vector2 = tile_map.map_to_local(random_carved_cell)
		spawn_object(object_scene, random_position)


func set_cell(x: int, y: int, value: int) -> void:
	if value == 0:
		tile_map.set_cell(0, Vector2i(x, y), 0, floor_tile)
		carved_cells.append(Vector2i(x, y))
	else:
		tile_map.set_cell(0, Vector2i(x, y), 0, wall_tile)


func fill_tile_map() -> void:
	tile_map.clear()
	carved_cells.clear()
	for x in range(width - 1):
		for y in range(height - 1):
			set_cell(x, y, layout_generator.layout_get(x, y))


func spawn_player() -> void:
	if not player_scene:
		return

	player = player_scene.instantiate()
	add_child(player)
	var first_cell: Vector2i = Vector2i(start_x, start_y)
	var start_position: Vector2 = tile_map.map_to_local(first_cell)
	player.position = start_position


func spawn_object(object_scene: PackedScene, object_position: Vector2) -> void:
	if not object_scene:
		return

	var object := object_scene.instantiate()
	add_child(object)
	object.position = object_position


func _on_layout_generated() -> void:
	fill_tile_map()


func _on_enemy_nav_timer_timeout() -> void:
	get_tree().call_group("enemies", "set_movement_target", player.position)
