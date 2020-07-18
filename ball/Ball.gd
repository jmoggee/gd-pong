extends KinematicBody2D


var speed = 300
var speed_incrementor = 30
var direction = Vector2.ZERO

var initial_speed = null

onready var bounce_sound = $BounceSound


func _ready():
	set_random_direction("x")
	initial_speed = speed
	
func _physics_process(delta):
	var collide = move_and_collide(direction * speed * delta)
	
	if collide is KinematicCollision2D and collide.collider is Node:
		var collider = collide.collider
		
		if collider.is_in_group("paddle"):
			bounce_from_paddle()
		elif collider.is_in_group("wall"):
			bounce_from_wall()

func set_random_direction(axis):
	randomize()
	direction[axis] = [-1, 1][randi() % 2]

func reset():
	speed = initial_speed
	set_random_direction("x")

func bounce_from_paddle():
	direction.x *= -1
	direction.y = randf() * 2.0 - 1
	
	speed += speed_incrementor
	
	bounce_sound.play()
	
func bounce_from_wall():
	direction.y *= -1
