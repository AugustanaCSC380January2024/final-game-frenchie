extends Control

var final_score

@onready var game_over = $"../GameOver"


func set_score(value):
	game_over.set_score_label(value)
	$Score.text = "SCORE: " + str(value)
