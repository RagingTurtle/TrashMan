extends Node2D

@onready var joystick: Joystick = $UILayer/HUD/Joystick
@onready var hud: Control = $UILayer/HUD
@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var fence_tile_map: TileMap = $TileMaps/FenceTileMap
@onready var trash_manager: Node2D = $"Trash Manager"

var enemy_scene: PackedScene = preload("res://scenes/characters/enemy.tscn")
var player_scene: PackedScene = preload("res://scenes/Characters/player.tscn")
var bag_scene: PackedScene = preload("res://scenes/items/bag.tscn")
var player: Player = null
var player_spawn_position: Vector2
var enemy: Enemy = null
var enemy_spawn_position: Vector2

func  _ready() -> void:
	hud.visible = false

func start_game() -> void:

	hud.visible = true
	player = player_scene.instantiate()
	player_spawn_position.x = viewport_size.x / 2
	var player_spawn_position_y_offset:float = 100
	player_spawn_position.y = viewport_size.y / 2  - player_spawn_position_y_offset
	player.global_position = player_spawn_position
	add_child(player)
	player.joystick = joystick
	
	trash_manager.bag = bag_scene.instantiate()
	trash_manager.setup_bag()
	player.add_child(trash_manager.bag)
	
	enemy = enemy_scene.instantiate()
	enemy_spawn_position.x = viewport_size.x / 2
	var enemy_spawn_position_y_offset:float = 0
	enemy_spawn_position.y = viewport_size.y / 2  - enemy_spawn_position_y_offset
	enemy.global_position = enemy_spawn_position
	add_child(enemy)
	enemy.trash_dropped.connect(_on_enemy_trash_drop)
	
func _on_enemy_trash_drop(trash_position:Vector2):
	trash_manager.spawn_trash(trash_position)
