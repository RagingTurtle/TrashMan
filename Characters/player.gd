extends CharacterBody2D

@export var speed: float = 300.0

@onready var joystick: Control = $"../UI/Joystick"

var movement_disabled: bool = false

func _physics_process(_delta):
	if !movement_disabled:
		player_movement()

func player_movement() -> void:
	var directionx: float = Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	var directiony: float = Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	var joystick_direction = joystick.posVector
	if joystick_direction:
		velocity = joystick_direction * speed
		
	move_and_slide()
