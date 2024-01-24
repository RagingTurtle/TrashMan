extends Area2D
class_name Trashcan

signal dispose_trash()

@onready var wait_timer: Timer = $WaitTimer
@onready var wait_timer_sprite: TextureProgressBar = $Sprite2D/WaitTimerProgressBar

var is_player_in_area: bool = false

func _process(_delta: float) -> void:
	if is_player_in_area and wait_timer.is_stopped():
		dispose_trash.emit()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_in_area = false

func  wait_timer_animation(tween_duration:float) -> void:
	wait_timer.start()
	var tween: Tween = create_tween()
	tween.tween_property(wait_timer_sprite, "value", wait_timer_sprite.min_value, tween_duration).from(wait_timer_sprite.max_value)
