extends Control

signal upgrade_stat

@export var coin_manager: Node2D
@export var player_body: Node2D

enum Item {
	TRASHCAN,
	BAGBOX,
	ENERGY_DRINK
}

const item_name: Dictionary = {
	Item.TRASHCAN: "trashcan",
	Item.BAGBOX: "bags", 
	Item.ENERGY_DRINK: "energy drink"
	}

var item_cost: Dictionary = {
	Item.TRASHCAN: 1,
	Item.BAGBOX: 1, 
	Item.ENERGY_DRINK: 1
	}
	
var selected_item: Item = Item.TRASHCAN
var old_coin_manager_z_index: int

func _on_trashcan_pressed() -> void:
	select_item(Item.TRASHCAN)
	shake_button($Background/Trashcan)

func _on_bag_box_pressed() -> void:
	select_item(Item.BAGBOX)
	shake_button($Background/BagBox)

func _on_energy_drink_pressed() -> void:
	select_item(Item.ENERGY_DRINK)
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

func select_item(item: Item) -> bool:
	if item not in item_name:
		return false

	var cost = item_cost[item]
	var dialog_text = "[color=black][font_size=10]"

	if cost > coin_manager.coin_amount:
		dialog_text += "you don't have enough\n"
		$BuyButton.visible = false
	else:
		dialog_text += item_name[item] + " costs " + str(cost).to_upper()
		$BuyButton.visible = true
		selected_item = item

	$Background/Dialog.text = dialog_text + "[img=10x10]res://Sprites/coin.png"
	return true

func _on_buy_button_pressed() -> void:
	coin_manager.coin_amount -= item_cost[selected_item]
	item_cost[selected_item] *= 2
	select_item(selected_item)
	emit_signal("upgrade_stat", selected_item)
	
func _on_exit_button_pressed() -> void:
	player_body.movement_disabled = false
	coin_manager.z_index = old_coin_manager_z_index
	self.hide()
