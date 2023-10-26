extends Node2D

@export_range(0,100) var max_trash: int = 5
@export var bag_fill_speed: float = 7
@export var trash_scene: PackedScene
@export var max_bag_capacity: int = 3
@export var bag: TextureProgressBar

@onready var coin_display_label: Label = $"../CoinDisplay/Coin Count"
@onready var available_trash: Node = $"Available Trash"
@onready var on_field: Node = $"Used Trash/On Field"
@onready var in_bag: Node = $"Used Trash/In Bag"
@onready var trashcan: Area2D = $Trashcan
@onready var bag_scale: Vector2 = bag.scale

var coin = preload("res://Scenes/coin.tscn")
var coin_count: int = 0

func _ready() -> void:
	coin_display_label.text = str(0)
	bag.min_value = 0
	bag.max_value = max_bag_capacity
	bag.value = in_bag.get_child_count()
	for i in range(max_trash):
		var trash_piece: Area2D = trash_scene.instantiate()
		trash_piece.connect("pick_up_trash", _on_pick_up_trash)
		trash_piece.visible = false
		available_trash.add_child(trash_piece)

func _process(delta: float) -> void:
	bag.value = lerp(bag.value, float(in_bag.get_child_count()), delta * bag_fill_speed)

func _on_pick_up_trash(trash_piece: Area2D) -> void:
	if in_bag.get_child_count() < max_bag_capacity:
		trash_piece.call_deferred("reparent", in_bag)
		trash_piece.visible = false
	else:
		bag_full_animation()
	
func _on_dispose_trash() -> void:
	if in_bag.get_child_count() > 0:
		var trash_piece: Area2D = in_bag.get_child(0)
		var coin_animation = coin.instantiate()
		#coin_animation.get_node("Coin").global_position = trashcan.global_position
		trashcan.add_child(coin_animation)
		trash_piece.call_deferred("reparent", available_trash)
		coin_count += 1
		coin_display_label.text = str(coin_count)

func _on_trash_dropped(location: Vector2) -> void:
	if available_trash.get_child_count() > 0:
		var dropped: Area2D = available_trash.get_child(0)
		dropped.call_deferred("reparent", on_field)
		dropped.global_position = location
		dropped.visible = true

func bag_full_animation() -> void:
	var tween_duration: float = .5
	var turn_red_tween: Tween = create_tween()
	turn_red_tween.set_loops(2)
	turn_red_tween.tween_property(bag, "modulate", Color.RED, tween_duration)
	turn_red_tween.tween_property(bag, "modulate", Color.WHITE, tween_duration).from(Color.RED)
	
	var bag_grow_amount: float = 1.25
	var pulse_size_tween: Tween = create_tween()
	pulse_size_tween.set_loops(2)
	pulse_size_tween.tween_property(bag, "scale", bag_scale * bag_grow_amount, tween_duration).from(bag_scale)
	pulse_size_tween.tween_property(bag, "scale", bag_scale, tween_duration).from(bag_scale * bag_grow_amount)
	
