extends Node

var batdeath = preload("res://Assets/Sounds/bat.wav")
var death = preload("res://Assets/Sounds/death.wav")
var jump = preload("res://Assets/Sounds/jump.wav")
var billyattack = preload("res://Assets/Sounds/billy5.wav")
var rosieattack = preload("res://Assets/Sounds/rosie5.wav")
var forfeit = preload("res://Assets/Sounds/footsteps-running-away-fading-2-103763.wav")
var attack = preload("res://Assets/Sounds/attack.wav")
var bossattack = preload("res://Assets/Sounds/bossattack.wav")
var bossdeath = preload("res://Assets/Sounds/bossdeathh.wav")

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
	elif sfx_name == "forfeit":
		stream = forfeit
	elif sfx_name == "attack":
		stream = attack
	elif sfx_name == "bossattack":
		stream = bossattack
	elif sfx_name == "bossdeath":
		stream = bossdeath
	else:
		print("Invalid SFX name")
		return
		
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	
	asp.play()
	
