extends Control

var caller

func _on_back_pressed() -> void:
	self.hide()
	caller.show()
