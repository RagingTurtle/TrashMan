extends Node

@export var wait_time_reduction: float = 0.01
@export var bag_capacity_increase: int = 1
@export var speed_increase: float = 50

enum Item {
	TRASHCAN,
	BAGBOX,
	ENERGY_DRINK
}

func _on_upgrade_stat(item: Item) -> void:
	match(item):
		Item.TRASHCAN:
			$"../Trash Manager/Trashcan/WaitTimer".wait_time -= wait_time_reduction
		Item.BAGBOX:
			$"../Trash Manager".max_bag_capacity += bag_capacity_increase
			$"../Player/Bag".max_value += bag_capacity_increase
		Item.ENERGY_DRINK:
			$"../Player".speed += speed_increase
		_:
			print("nothing")
