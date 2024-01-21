extends Sprite2D

@onready var parent = $".."

var pressing = false

var maxLength = 50
var deadzone = 15

func _ready():
	maxLength = parent.maxLength
	deadzone = parent.deadzone
	maxLength *= parent.scale.x

func _process(delta):
	var parent_global_position: Vector2 = parent.global_position
	if pressing:
		if get_global_mouse_position().distance_to(parent_global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle: float = parent_global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent_global_position.x + cos(angle)*maxLength
			global_position.y = parent_global_position.y + sin(angle)*maxLength
		calculateVector()
	else:
		global_position = lerp(global_position, parent_global_position, delta*50)
		parent.posVector = Vector2(0,0)
		
func calculateVector():
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x)/maxLength
	if abs((global_position.y - parent.global_position.y)) >= deadzone:
		parent.posVector.y = (global_position.y - parent.global_position.y)/maxLength
		
func _on_button_button_down():
	pressing = true


func _on_button_button_up():
	pressing = false
