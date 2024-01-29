extends Node2D

var currently_selected_char 
@onready var rosie = $Tilly
@onready var billy = $Billy
@onready var billyplayer = $BillyPlayer
@onready var rosieplayer = $RosiePlayer
@onready var light1 = $Light1
@onready var light2 = $Light2

func _on_rosie_2_pressed():
	rosie.play("Tilly")
	billy.stop()
	rosieplayer.play()
	currently_selected_char = "Tilly"
	light1.enabled = true
	light2.enabled = false


func _on_billy_2_pressed():
	billy.play("Billy")
	rosie.stop()
	billyplayer.play()
	currently_selected_char = "Billy"
	light1.enabled = false
	light2.enabled = true


func _on_play_pressed():
	if currently_selected_char:
		Game.set_player_character(currently_selected_char)
		get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
