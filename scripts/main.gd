extends Node

@onready var screens: CanvasLayer = $Screens
@onready var game: Node2D = $Game

var game_in_progress:bool = false

func _ready() -> void:
	screens.start_game.connect(_on_screens_start_game)
	
func _on_screens_start_game() -> void:
	game_in_progress = true
	game.start_game()
