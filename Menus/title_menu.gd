extends Control

@onready var scene_manager: Node = $".."
 
func _on_play_pressed() -> void:
	scene_manager.change_scene_to_file("res://Areas/grassy_area.tscn", self)

func _on_options_pressed() -> void:
	$MarginContainer.hide()
	$"Options Menu".caller = $MarginContainer
	$"Options Menu".show()

func _on_quit_pressed() -> void:
	get_tree().quit()
