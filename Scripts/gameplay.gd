extends Node2D

var player

var segments = [
	preload("res://Scenes/shape_1.tscn"),
	preload("res://Scenes/shape_2.tscn"),
	preload("res://Scenes/shape_3.tscn"),
	preload("res://Scenes/shape_4.tscn")
	]
var speed = 200

func _ready():
	get_player()
	var player_ins = player.instantiate()
	add_child(player_ins)
	randomize()
	spawn_inst(0, 0)
	spawn_inst(1024, 0)
	
func get_player():
	match Game.character_play:
		"Billy":
			player = load("res://Scenes/billy.tscn")
		"Rosie":
			player = load("res://Scenes/rosie.tscn")
func _physics_process(delta):
	for area in $Areas.get_children():
		area.position.x -= speed*delta
		if area.position.x < -1024:
			spawn_inst(area.position.x + 2048, 0)
			area.queue_free()
		
func spawn_inst(x, y):
	var inst = segments[randi() % len(segments)].instantiate()
	inst.position = Vector2(x, y)
	$Areas.add_child(inst)
	speed += 20
