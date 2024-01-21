extends CanvasLayer

signal start_game

@onready var title_screen: Screen = $TitleScreen
@onready var credits_screen: Screen = $CreditsScreen
@onready var options_screen: Control = $OptionsScreen
@onready var pause_screen: Control = $PauseScreen

var active_screen: Screen = null
var last_screen: Array[Screen]

func _ready() -> void:
	register_buttons()
	change_screen(title_screen, false)

func register_buttons() -> void:
	var buttons: Array[Node] = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)
				
func _on_button_pressed(button: Node) -> void:
	match button.name:
		"TitlePlay":
			change_screen(null, false)
			start_game.emit()
		"TitleOptions":
			change_screen(options_screen, true)
		"TitleCredits":
			change_screen(credits_screen, true)
		"TitleQuit":
			get_tree().quit()
		"CreditsBack":
			change_screen(last_screen.pop_back(), false)
		"OptionsBack":
			change_screen(last_screen.pop_back(), false)
		"PauseResume":
			change_screen(last_screen.pop_back(), false)
		"PauseOptions":
			change_screen(options_screen, true)
		"PauseQuit":
			get_tree().quit()
		

				
func change_screen(new_screen: Screen, record_last_screen: bool) -> void:
	if active_screen:
		var disappear_tween:Tween = active_screen.disappear()
		await(disappear_tween.finished)
		if record_last_screen:
			last_screen.push_back(active_screen)
	active_screen = new_screen
	if active_screen:
		var appear_tween:Tween = active_screen.appear()
		await(appear_tween.finished)
