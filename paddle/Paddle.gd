extends KinematicBody2D

export (int) var player_no = 1
export (int) var speed = 700
export (bool) var is_player_controlled = true

func _physics_process(delta):
	if is_player_controlled:
		apply_player_input(delta)

func apply_player_input(delta):
	var player_pre = "p" + str(player_no)
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed(player_pre + "_down"):
		move_down(velocity, speed, delta)
	if Input.is_action_pressed(player_pre + "_up"):
		move_up(velocity, speed, delta)

func move_down(velocity, move_speed, delta):
	velocity.y += move_speed * delta
	move_and_collide(velocity)
	
func move_up(velocity, move_speed, delta):
	velocity.y -= move_speed * delta
	move_and_collide(velocity)
