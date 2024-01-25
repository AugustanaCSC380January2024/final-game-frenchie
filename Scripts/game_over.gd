extends Control

@onready var game_over_score = $Score
@onready var high_score = $HiScore



func set_score_label(score):
	game_over_score.text = "YOUR SCORE: " +str(score)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
	
func set_high_score(score):
	high_score.text = "HIGH SCORE: " + str(score)
	
