extends Area2D

@onready var shop: Control = $"../Shop"
@onready var coin_manager: Node2D = $"../Coin Manager"

func _on_body_entered(body: Node2D) -> void:
	if (body.name) == "Player":
		body.movement_disabled = true
		shop.old_coin_manager_z_index = coin_manager.z_index
		coin_manager.z_index = shop.z_index + 1
		shop.show()
