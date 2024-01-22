extends Area2D
class_name trash_piece

@onready var sprite: Sprite2D = $Sprite2D

signal pick_up_trash(trash_piece)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		pick_up_trash.emit(self)
