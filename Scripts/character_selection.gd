extends Node2D

var currently_selected_char 
@onready var rosie = $Rosie
@onready var billy = $Billy
@onready var billyplayer = $BillyPlayer
@onready var rosieplayer = $RosiePlayer

func _on_rosie_2_pressed():
	rosie.play("Rosie")
	billy.stop()
	rosieplayer.play()
	currently_selected_char = "Rosie"


func _on_billy_2_pressed():
	billy.play("Billy")
	rosie.stop()
	billyplayer.play()
	currently_selected_char = "Billy"


func _on_play_pressed():
	if currently_selected_char:
		Game.set_player_character(currently_selected_char)
		get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
