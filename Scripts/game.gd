extends Node2D

var character_play : String
var current_health = 100
var max_health = 100
var damage = randi_range(20, 31)


func set_player_character(player_character):
	self.character_play = player_character
