extends Node2D
@onready var spawn_pos = $SpawnPositionsClock

var clock_scene = preload("res://Scenes/clock.tscn")

func _on_timer_timeout():
	spawn_clock()

func spawn_clock():
	var spawn_pos_array = spawn_pos.get_children()
	var ran_spawn_pos = spawn_pos_array.pick_random()
	var clock_ins = clock_scene.instantiate()
	clock_ins.global_position = ran_spawn_pos.global_position
	add_child(clock_ins)
