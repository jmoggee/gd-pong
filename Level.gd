extends Node

var scores = {
	1: 0,
	2: 0,
}
onready var score_labels = {
	1: $ScoreLabel1,
	2: $ScoreLabel2,
}
onready var play_label = $PlayLabel
onready var paddle1 = $Paddle1
onready var paddle2 = $Paddle2
onready var ball = $Ball
onready var gameover_sound = $GameOverSound

var initial_positions = {
	"paddle1": null,
	"paddle2": null,
	"ball": null
}

func _ready():
	set_initial_positions()
	pause_game()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		reset_positions()
		ball.reset()
		unpause_game()
	if Input.is_action_just_pressed("ui_cancel"):
		set_score(1, 0)
		set_score(2, 0)

func set_initial_positions():
	initial_positions["paddle1"] = paddle1.position
	initial_positions["paddle2"] = paddle2.position
	initial_positions["ball"] = ball.position

func reset_positions():
	paddle1.position = initial_positions["paddle1"]
	paddle2.position = initial_positions["paddle2"]
	ball.position = initial_positions["ball"]

func set_score(player_no, score):
	scores[player_no] = score
	render_score(player_no)

func increment_score(player_no):
	scores[player_no] += 1
	render_score(player_no)
	
func render_score(player_no):
	score_labels[player_no].text = str(scores[player_no])
	
func pause_game():
	get_tree().paused = true
	$PlayLabel.visible = true
	
func unpause_game():
	get_tree().paused = false
	$PlayLabel.visible = false

func _on_ScoringArea_body_entered(body, player_no):
	if body.is_in_group("ball"):
		increment_score(player_no)
		gameover_sound.play()
		pause_game()
		
