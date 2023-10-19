extends Area2D

signal dispose_trash()
var is_player_in_area: bool = false
@onready var wait_timer: Timer = $WaitTimer
@onready var in_bag: Node = $"../Used Trash/In Bag"

func _process(delta: float) -> void:
	if is_player_in_area:
		if !wait_timer.is_stopped():
			return
		if in_bag.get_child_count() > 0:
			print("dump")
			emit_signal("dispose_trash")
			wait_timer.start()
	
func _on_body_entered(body: Node2D) -> void:
	if (body.name) == "Player" and in_bag != null:
		is_player_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if (body.name) == "Player":
		is_player_in_area = false

func _on_wait_timer_timeout() -> void:
	print("time out")
