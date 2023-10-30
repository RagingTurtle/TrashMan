extends Control

@onready var coin_manager: Node2D = $"Coin Manager"

var shop_items: Dictionary = {"trashcan": 2, "bag": 3, "drink": 1}
var selected_item: String
var player_body: Node2D
var main_scene_coin_manager: Node2D

func _on_trashcan_pressed() -> void:
	shake_button($Background/Trashcan)
	select_item_debug(select_item("trashcan"))

func _on_bag_box_pressed() -> void:
	select_item_debug(select_item("bag"))
	shake_button($Background/BagBox)

func _on_energy_drink_pressed() -> void:
	select_item_debug(select_item("drink"))
	shake_button($Background/EnergyDrink)

func shake_button(button: TextureButton):
	var start_position: Vector2 = button.position
	for i in range(10):
		var direction: Vector2 = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
		button.position = start_position + (direction * 2)
		await get_tree().create_timer(.01).timeout
		button.position = start_position

func _on_bag_box_focus_entered() -> void:
	$Background/BagBox/Bag/BagFocus.visible = true

func _on_bag_box_focus_exited() -> void:
	$Background/BagBox/Bag/BagFocus.visible = false

func select_item(item: String) -> bool:
	if item in shop_items:
		if shop_items[item] > coin_manager.coin_amount:
			$Background/Dialog.text = "[color=black][font_size=10]"
			$Background/Dialog.text += "you don't have enough\n"
			$Background/Dialog.text += "[img=10x10]res://Sprites/coin.png"
			$BuyButton.visible = false
			return false
		else:
			$Background/Dialog.text = "[color=black][font_size=10]"
			$Background/Dialog.text += (str(item) + " costs " + str(shop_items[item])).to_upper()
			$Background/Dialog.text += "[img=10x10]res://Sprites/coin.png"
			$BuyButton.visible = true
			selected_item = item
			return true
	return false

func _on_buy_button_pressed() -> void:
	coin_manager.coin_amount -= shop_items[selected_item]
	select_item(selected_item)

func select_item_debug(result: bool) -> void:
	if result:
		print("success")
	else:
		print("fail")
	print(coin_manager.coin_amount)


func _on_exit_button_pressed() -> void:
	player_body.movement_disabled = false
	main_scene_coin_manager.coin_amount = coin_manager.coin_amount
	self.queue_free()
