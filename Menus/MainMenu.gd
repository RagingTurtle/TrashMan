extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Areas/grassy_area.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/options_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
