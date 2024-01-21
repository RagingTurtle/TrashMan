extends Control
class_name Screen

var full_alpha:float = 1.0
var no_alpha:float = 0.0
@export var fade_delay:float = 0.5
	
func _ready() -> void:
	visible = false
	modulate.a = 0.0
	
	get_tree().call_group("buttons", "set_disabled", true)
	
func appear() -> Tween:
	visible = true
	
	var tween:Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate:a", full_alpha, fade_delay)
	tween.tween_callback(get_tree().call_group.bind("buttons", "set_disabled", false))
	return tween
	
func disappear() -> Tween:
	get_tree().call_group("buttons", "set_disabled", true)

	var tween:Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate:a", no_alpha, fade_delay)
	tween.tween_callback(set_visible.bind(false))
	return tween
