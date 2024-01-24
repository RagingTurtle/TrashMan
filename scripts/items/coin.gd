extends Sprite2D
@onready var coin: Sprite2D = self
@export var durationtween: float = .7

func _ready() -> void:
	var spin_tween = create_tween()
	spin_tween.set_loops()
	spin_tween.tween_property(coin, "frame", 7, durationtween).from(0).set_ease(Tween.EASE_OUT)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(coin, "scale", Vector2.ONE, durationtween).from(Vector2.ZERO)
	tween.tween_property(coin, "global_position", coin.global_position + (Vector2.UP * 48), durationtween)
	tween.tween_property(coin, "modulate", Color.TRANSPARENT, durationtween).set_delay(durationtween)
	tween.tween_callback(spin_tween.kill).set_delay(durationtween*2)
	tween.tween_callback(coin.queue_free).set_delay(durationtween*2)
