extends Area2D

const SHOP_SCENE: String = "res://Areas/shop.tscn"

func _on_body_entered(body: Node2D) -> void:
	if (body.name) == "Player":
		body.movement_disabled = true
		var shop = preload(SHOP_SCENE).instantiate()
		shop.player_body = body
		$"../..".add_child(shop)
		shop.coin_manager.coin_amount = $"../Coin Manager".coin_amount
		shop.main_scene_coin_manager = $"../Coin Manager"
		shop.main_scene = $".."
		shop.upgrade_stat.connect($"../Item Boost Manager"._on_upgrade_stat)
