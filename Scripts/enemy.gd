extends CharacterBody2D

const SPEED = 300.0

var walk_timer = Timer.new()

func _ready():
	#start timer with it times out change direction
	walk_timer.connect("timeout", _change_walk_direction)
	walk_timer.wait_time = 1
	walk_timer.one_shot = true
	add_child(walk_timer)
	walk_timer.start()
	
func _physics_process(delta):
	move_and_slide()

func _change_walk_direction():
	var direction = Vector2(randi_range(-1,1), randi_range(-1,1)).normalized()
	velocity = direction * SPEED
	walk_timer.start()
