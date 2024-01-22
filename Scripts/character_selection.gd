extends Node2D

var currently_selected_char 
@onready var rosie = $Rosie
@onready var billy = $Billy

func _on_rosie_2_pressed():
	rosie.play("Rosie")
	billy.stop()
	currently_selected_char = "Rosie"


func _on_billy_2_pressed():
	billy.play("Billy")
	rosie.stop()
	currently_selected_char = "Billy"


func _on_play_pressed():
	if currently_selected_char:
		Game.set_player_character(currently_selected_char)
		get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
