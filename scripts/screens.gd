extends CanvasLayer

@onready var title_screen: Screen = $TitleScreen

var active_screen: Screen = null

func _ready() -> void:
	change_screen(title_screen)
	
func change_screen(new_screen: Control) -> void:
	if active_screen:
		var disappear_tween:Tween = active_screen.disappear()
		await(disappear_tween.finished)
	active_screen = new_screen
	if active_screen:
		var appear_tween:Tween = active_screen.appear()
		await(appear_tween.finished)
