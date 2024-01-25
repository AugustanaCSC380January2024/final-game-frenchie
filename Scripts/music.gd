extends Node

var batdeath = preload("res://Assets/Sounds/bat.wav")
var death = preload("res://Assets/Sounds/death.wav")
var jump = preload("res://Assets/Sounds/jump.wav")
var billyattack = preload("res://Assets/Sounds/billy5.wav")
var rosieattack = preload("res://Assets/Sounds/rosie5.wav")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "death":
		stream = death
	elif sfx_name == "batdeath":
		stream = batdeath
	elif sfx_name == "jump":
		stream = jump
	elif sfx_name == "billyattack":
		stream = billyattack
	elif sfx_name == "rosieattack":
		stream = rosieattack
	else:
		print("Invalid SFX name")
		return
		
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	
	asp.play()
	
