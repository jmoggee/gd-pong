extends Node


var initial_positions = {
	"paddle1": null,
	"paddle2": null,
	"ball": null
}

onready var play_label = $PlayLabel
onready var paddle1 = $Paddle1
onready var paddle2 = $Paddle2
onready var ball = $Ball
onready var gameover_sound = $GameOverSound
onready var score_manager = $ScoreManager

func _ready():
	set_initial_positions()
	pause_game()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		reset_positions()
		ball.reset()
		unpause_game()
	if Input.is_action_just_pressed("ui_cancel"):
		score_manager.reset_scores()

func set_initial_positions():
	initial_positions["paddle1"] = paddle1.position
	initial_positions["paddle2"] = paddle2.position
	initial_positions["ball"] = ball.position

func reset_positions():
	paddle1.position = initial_positions["paddle1"]
	paddle2.position = initial_positions["paddle2"]
	ball.position = initial_positions["ball"]

func pause_game():
	get_tree().paused = true
	$PlayLabel.visible = true
	
func unpause_game():
	get_tree().paused = false
	$PlayLabel.visible = false

func _on_game_over():
	gameover_sound.play()
	pause_game()
