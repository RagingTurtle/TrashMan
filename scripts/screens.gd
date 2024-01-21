extends CanvasLayer

@onready var title_screen: Screen = $TitleScreen
@onready var credits_screen: Screen = $CreditsScreen
@onready var options_screen: Control = $OptionsScreen

var active_screen: Screen = null
var last_screen: Screen = null

func _ready() -> void:
	register_buttons()
	change_screen(title_screen)

func register_buttons() -> void:
	var buttons: Array[Node] = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)
				
func _on_button_pressed(button: Node) -> void:
	match button.name:
		"TitlePlay":
			print(button.name)
		"TitleOptions":
			change_screen(options_screen)
		"TitleCredits":
			change_screen(credits_screen)
		"TitleQuit":
			get_tree().quit()
		"CreditsBack":
			change_screen(last_screen)
		"OptionsBack":
			change_screen(last_screen)

				
func change_screen(new_screen: Screen) -> void:
	if active_screen:
		var disappear_tween:Tween = active_screen.disappear()
		await(disappear_tween.finished)
	last_screen = active_screen
	active_screen = new_screen
	if active_screen:
		var appear_tween:Tween = active_screen.appear()
		await(appear_tween.finished)
