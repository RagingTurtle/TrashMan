extends Control

@onready var scene_manager: Node = $".."
@export var play_scene: PackedScene
 
func _on_play_pressed() -> void:
	scene_manager.change_scene_to_packedscene(play_scene, self)

func _on_options_pressed() -> void:
	_hide_and_show($MarginContainer,$"Options Menu")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	_hide_and_show($MarginContainer,$"credits")

func _hide_and_show(hide_this, show_this) -> void:
	hide_this.hide()
	show_this.caller = hide_this
	show_this.show()
	
