extends CharacterBody2D
class_name Enemy

@export var speed: float = 300.0
@export var walk_timer_delay: float = 1
@export var drop_timer_delay: float = 1.5
var walk_timer: Timer = Timer.new()
var drop_timer: Timer = Timer.new()

signal trash_dropped(Vector2)

func _ready():
	walk_timer.connect("timeout", _change_walk_direction)
	walk_timer.wait_time = walk_timer_delay
	walk_timer.one_shot = true
	add_child(walk_timer)
	walk_timer.start()

	drop_timer.connect("timeout", drop_trash)
	drop_timer.wait_time = drop_timer_delay
	add_child(drop_timer)
	drop_timer.start()
		
func _physics_process(delta):
	move_and_slide()
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)

func _change_walk_direction():
	var direction: Vector2 = Vector2(randi_range(-1,1), randi_range(-1,1)).normalized()
	velocity = direction * speed
	walk_timer.start()
	
func drop_trash():
	trash_dropped.emit(global_position)
