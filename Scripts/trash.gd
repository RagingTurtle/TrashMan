extends Area2D

signal pick_up_trash(Area2d)

func _on_body_entered(body: Node2D) -> void:
	if (body.name) == "Player":
		emit_signal("pick_up_trash", self)
