extends Node2D

var character_play : String
var current_health = 35
var max_health = 35
var damage = 20


func set_player_character(player_character):
	self.character_play = player_character
