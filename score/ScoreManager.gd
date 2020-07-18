extends Node

signal game_over

var scores = {
	1: 0,
	2: 0,
}
onready var score_labels = {
	1: $ScoreLabel1,
	2: $ScoreLabel2,
}

func set_score(player_no, score):
	scores[player_no] = score
	render_score(player_no)

func increment_score(player_no):
	scores[player_no] += 1
	render_score(player_no)
	
func reset_scores():
	set_score(1, 0)
	set_score(2, 0)
	
func render_score(player_no):
	score_labels[player_no].text = str(scores[player_no])

func _on_ScoringArea_body_entered(body, player_no):
	if body.is_in_group("ball"):
		increment_score(player_no)
		emit_signal("game_over")
