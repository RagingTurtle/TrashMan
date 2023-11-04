extends Control


func _on_resume_pressed() -> void:
	$"../".pauseMenu()


func _on_options_pressed() -> void:
	$MarginContainer.hide()
	$"Options Menu".caller = $MarginContainer
	$"Options Menu".show()


func _on_quit_pressed() -> void:
	get_tree().quit()
