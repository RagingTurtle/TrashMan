extends Button
class_name ScreenButton

signal clicked(button)

func _on_pressed():
	clicked.emit(self)
