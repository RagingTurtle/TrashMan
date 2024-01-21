extends Node2D
@onready var joystick: Joystick = $UILayer/HUD/Joystick

@onready var viewport_size:Vector2 = get_viewport_rect().size

var player_scene: PackedScene = preload("res://scenes/Characters/player.tscn")

var player:Player = null
var player_spawn_position: Vector2

func  _ready() -> void:
	pass

func start_game() -> void:
	print("starting game")
	player = player_scene.instantiate()
	print(player.position)
	player_spawn_position.x = viewport_size.x / 2
	var player_spawn_position_y_offset:float = 0
	player_spawn_position.y = viewport_size.y / 2  - player_spawn_position_y_offset
	printt(player.global_position, player_spawn_position)
	player.global_position = player_spawn_position
	add_child(player)
	player.joystick = joystick
