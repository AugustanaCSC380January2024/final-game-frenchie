extends Node2D

var player
var score = 0
var game_running = true
var player_ins
@onready var hud = $UILayer/HUD
@onready var ui = $UILayer

var segments = [
	preload("res://Scenes/shape_1.tscn"),
	preload("res://Scenes/shape_2.tscn"),
	preload("res://Scenes/shape_3.tscn"),
	preload("res://Scenes/shape_4.tscn"),
	preload("res://Scenes/shape_5.tscn"),
	preload("res://Scenes/shape6.tscn"),
	preload("res://Scenes/shape_7.tscn")
	]
var speed = 150

func _ready():
	get_player()
	player_ins = player.instantiate()
	player_ins.playerdie.connect(on_player_die)
	add_child(player_ins)
	player_ins.position = $PlayerPosition.position
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
		if area.position.x < -1050:
			spawn_inst(area.position.x + 2048, 0)
			area.queue_free()
		
func spawn_inst(x, y):
	var inst = segments[randi() % len(segments)].instantiate()
	inst.position = Vector2(x, y)
	$Areas.add_child(inst)
	speed += 5

func _process(delta):
	if game_running == true:
		score+= 1
		hud.set_score(score)
	else:
		hud.set_score(score)


func _on_deathzone_area_entered(area):
	area.queue_free()


func _on_spawner_bat_spawned(bat_ins):
	#bat_ins.connect("died", on_bat)
	add_child(bat_ins)


func _on_spawner_clock_clock_spawned(clock_ins):
	clock_ins.connect("claimed", on_clock_claimed)
	add_child(clock_ins)

func on_clock_claimed():
	speed -= 10
	score += 100
	
#func on_bat():
	#await get_tree().create_timer(1).timeout
	#game_running == false
	#ui.show_game_over(true)


func _on_player_deathzone_body_entered(body):
	game_running == false
	await get_tree().create_timer(1).timeout
	ui.show_game_over(true)

func on_player_die():
	await get_tree().create_timer(1).timeout
	ui.show_game_over(true)
