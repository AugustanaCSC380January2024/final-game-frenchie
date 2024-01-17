extends Node2D

@onready var rosie = $Rosie
@onready var billy = $Billy

func _on_rosie_2_pressed():
	rosie.play("Rosie")
	billy.stop()


func _on_billy_2_pressed():
	billy.play("Billy")
	rosie.stop()


func _on_play_pressed():
	pass
