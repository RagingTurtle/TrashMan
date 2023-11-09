extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu

var paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale =0
		
	paused =!paused
