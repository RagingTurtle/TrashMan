extends Area2D

signal dispose_trash()
var is_player_in_area: bool = false
@onready var wait_timer: Timer = $WaitTimer
@onready var in_bag: Node = $"../Used Trash/In Bag"
@onready var wait_timer_sprite: TextureProgressBar = $Sprite2D/WaitTimerProgressBar

func _process(_delta: float) -> void:
	if is_player_in_area and wait_timer.is_stopped() and in_bag.get_child_count() > 0:
		emit_signal("dispose_trash")
		wait_timer_animation(wait_timer.wait_time)
		wait_timer.start()

func _on_body_entered(body: Node2D) -> void:
	if (body.name) == "Player" and in_bag != null:
		is_player_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if (body.name) == "Player":
		is_player_in_area = false

func  wait_timer_animation(tween_duration:float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(wait_timer_sprite, "value", wait_timer_sprite.min_value, tween_duration).from(wait_timer_sprite.max_value)
