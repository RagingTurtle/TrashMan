extends Node2D

@export_range(0,100) var max_trash: int = 5
@onready var available_trash: Node = $"Available Trash"
@export var trash_scene: PackedScene
@onready var on_field: Node = $"Used Trash/On Field"
@onready var in_bag: Node = $"Used Trash/In Bag"

func _ready() -> void:
	for trash in max_trash:
		print(trash)
		var trash_piece = trash_scene.instantiate()
		trash_piece.connect("pick_up_trash", _on_pick_up_trash)
		trash_piece.visible = false
		available_trash.add_child(trash_piece)
	

func _on_pick_up_trash(trash_piece: Area2D) -> void:
	trash_piece.call_deferred("reparent", in_bag)
	#tween to bag
	trash_piece.visible = false
	
func _on_dispose_trash() -> void:
	print(in_bag.get_child_count())
	if in_bag.get_child_count() > 0:
		var trash_piece = in_bag.get_child(0)
		#tween from bag to can
		trash_piece.call_deferred("reparent", available_trash)

func _on_trash_dropped(location: Vector2) -> void:
	if available_trash.get_child_count() > 0:
		var dropped = available_trash.get_child(0)
		dropped.call_deferred("reparent", on_field)
		dropped.global_position = location
		dropped.visible = true

