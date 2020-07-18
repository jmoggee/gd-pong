extends KinematicBody2D

export (int) var player_no = 1
export (int) var speed = 700


func _physics_process(delta):
	var player_pre = "p" + str(player_no)
	
	var velocity = Vector2()
	if Input.is_action_pressed(player_pre + "_down"):
		velocity.y += speed * delta
		
	if Input.is_action_pressed(player_pre + "_up"):
		velocity.y -= speed * delta
		
	move_and_collide(velocity)
