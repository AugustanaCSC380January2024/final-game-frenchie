extends Node2D

var character_play : String
var current_health = 150
var max_health = 150
var damage = randi_range(30, 41)




func set_player_character(player_character):
	self.character_play = player_character
