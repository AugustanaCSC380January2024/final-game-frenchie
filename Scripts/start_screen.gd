extends Control


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/character_selection.tscn")


func _on_quit_pressed():
	get_tree().quit()
