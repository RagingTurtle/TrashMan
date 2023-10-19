extends Node2D

@export_range(0,100) var max_trash: int = 5
@export var bag_fill_speed: float = 7
@export var trash_scene: PackedScene
@export var max_bag_capacity: int = 3

@onready var available_trash: Node = $"Available Trash"
@onready var on_field: Node = $"Used Trash/On Field"
@onready var in_bag: Node = $"Used Trash/In Bag"
@onready var texture_progress_bar: TextureProgressBar = $"../Player/TextureProgressBar"

func _ready() -> void:
	texture_progress_bar.min_value = 0
	texture_progress_bar.max_value = max_bag_capacity
	texture_progress_bar.value = in_bag.get_child_count()
	for i in range(max_trash):
		var trash_piece: Area2D = trash_scene.instantiate()
		trash_piece.connect("pick_up_trash", _on_pick_up_trash)
		trash_piece.visible = false
		available_trash.add_child(trash_piece)

func _process(delta: float) -> void:
	texture_progress_bar.value = lerp(texture_progress_bar.value, float(in_bag.get_child_count()), delta * bag_fill_speed)

func _on_pick_up_trash(trash_piece: Area2D) -> void:
	if in_bag.get_child_count() < max_bag_capacity:
		trash_piece.call_deferred("reparent", in_bag)
		#tween to bag
		trash_piece.visible = false
	
func _on_dispose_trash() -> void:
	if in_bag.get_child_count() > 0:
		var trash_piece: Area2D = in_bag.get_child(0)
		#tween from bag to can
		trash_piece.call_deferred("reparent", available_trash)

func _on_trash_dropped(location: Vector2) -> void:
	if available_trash.get_child_count() > 0:
		var dropped: Area2D = available_trash.get_child(0)
		dropped.call_deferred("reparent", on_field)
		dropped.global_position = location
		dropped.visible = true
