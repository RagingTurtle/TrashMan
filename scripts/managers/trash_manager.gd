extends Node2D

@export_range(0,100) var trash_pool_size: int = 5
@export var bag_fill_speed: float = 7
@export var max_bag_capacity: int = 3
@export var trash_texture_list : Array[Texture2D] = []

@onready var trash_pool = $TrashPool
@onready var on_field: Node = $"Used Trash/On Field"
@onready var in_bag: Node = $"Used Trash/In Bag"

@onready var trash_scene: PackedScene = preload("res://scenes/items/trash_piece.tscn")
@onready var coin = preload("res://Items/coin.tscn")

var bag: TextureProgressBar = null
var bag_scale: Vector2
var trash_spawner: Enemy = null

func _ready() -> void:
	initialize_trash_pool()

func _process(delta: float) -> void:
	if bag:
		bag.value = lerp(bag.value, float(in_bag.get_child_count()), delta * bag_fill_speed)

func initialize_trash_pool() -> void:
	for i in range(trash_pool_size):
		var trash_piece: Area2D = trash_scene.instantiate()
		trash_piece.connect("pick_up_trash", _on_pick_up_trash)
		trash_piece.visible = false
		trash_pool.add_child(trash_piece)

func _on_pick_up_trash(trash_piece: Area2D) -> void:
	if in_bag.get_child_count() < max_bag_capacity:
		trash_piece.call_deferred("reparent", in_bag)
		trash_piece.visible = false
	else:
		bag_full_animation()
	
#func _on_dispose_trash() -> void:
#	if in_bag.get_child_count() > 0:
#		var trash_piece: Area2D = in_bag.get_child(0)
#		var coin_animation = coin.instantiate()
#		#coin_animation.get_node("Coin").global_position = trashcan.global_position
#		trashcan.add_child(coin_animation)
#		trash_piece.call_deferred("reparent", available_trash)
#		coin_manager.coin_amount += 1

func spawn_trash(location: Vector2) -> void:
	if trash_pool.get_child_count() > 0:
		var dropped: Area2D = trash_pool.get_child(0)
		change_sprite(dropped)
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
	
func change_sprite(trash_piece: Area2D) -> void:
	trash_piece.sprite.texture = trash_texture_list.pick_random()

func setup_bag() -> void:
	bag.min_value = 0.0
	bag.max_value = max_bag_capacity
	bag.value = in_bag.get_child_count()
	bag_scale = bag.scale
