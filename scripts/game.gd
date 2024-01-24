extends Node2D

@onready var joystick: Joystick = $UILayer/HUD/Joystick
@onready var hud: Control = $UILayer/HUD
@onready var fence_tile_map: TileMap = $TileMaps/FenceTileMap
@onready var trash_manager: Node2D = $"Trash Manager"
@onready var coin_manager = $"Coin Manager"
@onready var coin_counter = $"UILayer/HUD/Coin Display/Coin Counter"


@onready var viewport_size: Vector2 = get_viewport_rect().size

var player_scene: PackedScene = preload("res://scenes/Characters/player.tscn")
var enemy_scene: PackedScene = preload("res://scenes/characters/enemy.tscn")
var bag_scene: PackedScene = preload("res://scenes/items/bag.tscn")
var trashcan_scene: PackedScene = preload("res://scenes/items/trashcan.tscn")
var coin_scene: PackedScene = preload("res://scenes/items/coin.tscn")

var player: Player = null
var player_spawn_position: Vector2
var enemy: Enemy = null
var enemy_spawn_position: Vector2
var trashcan: Trashcan = null
var trashcan_spawn_position: Vector2

func  _ready() -> void:
	hud.visible = false

func start_game() -> void:
	
	coin_manager.coin_amount_changed.connect(_on_coin_amount_changed)
	coin_manager.coin_amount += 0

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
	
	trashcan = trashcan_scene.instantiate()
	trashcan_spawn_position.x = viewport_size.x / 2
	var trashcan_spawn_position_y_offset:float = 0
	trashcan_spawn_position.y = viewport_size.y / 2  - trashcan_spawn_position_y_offset
	trashcan.global_position = trashcan_spawn_position
	add_child(trashcan)
	trashcan.dispose_trash.connect(_on_trashcan_dispose_trash)
	
	enemy = enemy_scene.instantiate()
	enemy_spawn_position.x = viewport_size.x / 2
	var enemy_spawn_position_y_offset:float = 0
	enemy_spawn_position.y = viewport_size.y / 2  - enemy_spawn_position_y_offset
	enemy.global_position = enemy_spawn_position
	add_child(enemy)
	enemy.trash_dropped.connect(_on_enemy_trash_drop)
	
func _on_enemy_trash_drop(trash_position:Vector2):
	trash_manager.spawn_trash(trash_position)
	
func _on_trashcan_dispose_trash():
	var success = trash_manager.dispose_trash()
	if success:
		trashcan.wait_timer_animation(trashcan.wait_timer.wait_time)
		var coin_animation:  = coin_scene.instantiate()
		trashcan.add_child(coin_animation)
		coin_manager.coin_amount += 1

func _on_coin_amount_changed(coin_amount):
	coin_counter.text = str(coin_amount)
