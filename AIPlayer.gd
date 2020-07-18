extends Node

onready var paddle = get_node("../Paddle2")
onready var ball = get_node("../Ball")

export (int) var max_speed = 400
export (int) var difficulty = 100

var speed = 200
var is_speed_set = false
var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	if ball.direction.x > 0:
		if not is_speed_set:
			set_random_speed()
			is_speed_set = true
		follow_ball(delta)
	else:
		is_speed_set = false

func set_random_speed():
	rng.randomize()
	speed = rng.randi_range(max_speed - difficulty, max_speed)
	
func follow_ball(delta):
	var velocity = Vector2.ZERO
	if ball.position.y > paddle.position.y:
		paddle.move_down(velocity, speed, delta)
	if ball.position.y < paddle.position.y:
		paddle.move_up(velocity, speed, delta)
