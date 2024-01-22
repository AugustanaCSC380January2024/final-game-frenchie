extends Node2D

@onready var spawn_pos = $SpawnPositions

var bat_scene = preload("res://Scenes/bat.tscn")

func _on_timer_timeout():
	spawn_bats()

func spawn_bats():
	var spawn_pos_array = spawn_pos.get_children()
	var ran_spawn_pos = spawn_pos_array.pick_random()
	var bat_ins = bat_scene.instantiate()
	bat_ins.global_position = ran_spawn_pos.global_position
	add_child(bat_ins)
	
