extends Node2D

var player
var score = 0
var game_running: bool
var player_ins
@onready var hud = $UILayer/HUD
@onready var ui = $UILayer
@onready var gos = $UILayer/GameOver
@onready var bossfightscn = $Bossfight
@onready var bosscamera = $Bossfight/Camera2D
var bossscene = preload("res://Scenes/boss_1.tscn")
var boss_ins = bossscene.instantiate()
var bossfightscene = preload("res://Scenes/bossfight.tscn")
#var random_value = randi() % 5 * 5 + 190
var random_value = 170
var isBossAlive



var segments = [
	preload("res://Scenes/shape_1.tscn"),
	preload("res://Scenes/shape_2.tscn"),
	preload("res://Scenes/shape_3.tscn"),
	preload("res://Scenes/shape_4.tscn"),
	preload("res://Scenes/shape6.tscn"),
	preload("res://Scenes/shape_7.tscn")
	]
var speed = 150
var highscore

func _ready():
	isBossAlive = true
	print(random_value)
	$UILayer/Bossfight.boss_chet.connect(boss_die)
	$UILayer/Bossfight.bochay.connect(bo_chay)
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		highscore = save_file.get_32()
	else:
		highscore = 0
		save_game()
		
	game_running = true
	get_player()
	player_ins = player.instantiate()
	player_ins.playerdie.connect(on_player_die)
	add_child(player_ins)
	player_ins.position = $PlayerPosition.position
	randomize()
	spawn_inst(0, 0)
	spawn_inst(1024, 0)
func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(highscore)
	
	
func get_player():
	match Game.character_play:
		"Billy":
			player = load("res://Scenes/billy.tscn")
		"Tilly":
			player = load("res://Scenes/tilly.tscn")
func _physics_process(delta):
	for area in $Areas.get_children():
		area.position.x -= speed*delta
		if (area.position.x < -1060):
			spawn_inst(area.position.x + 2048, 0)
			print(speed)
			if (speed == random_value):
				spawn_boss(area.position.x + 2048, 0)
			area.queue_free()
		
func spawn_inst(x, y):
	var inst = segments[randi() % len(segments)].instantiate()
	inst.position = Vector2(x, y)
	$Areas.add_child(inst)
	speed += 5

func spawn_boss(x, y):
	#var boss_ins = bossscene.instantiate()
	if isBossAlive:
		boss_ins.get_node("BossFire").boss_showup.connect(_boss_encounter)
		boss_ins.position = Vector2(x, y - 800)
		$Areas.add_child(boss_ins)
	
	

func _process(delta):
	if game_running:
		score+= 1
		if score > highscore:
			highscore = score
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



func _on_player_deathzone_body_entered(body):
	save_game()
	gos.set_high_score(highscore)
	game_running = false
	await get_tree().create_timer(1).timeout
	ui.show_game_over(true)

func on_player_die():
	save_game()
	gos.set_high_score(highscore)
	game_running = false
	await get_tree().create_timer(1).timeout
	ui.show_game_over(true)
	
func _boss_encounter():
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	ui.show_boss_scene(true)
	
func boss_die():
	isBossAlive = false
	score = score + 5000
	boss_ins.get_node("BossFire").queue_free()
	boss_ins.get_node("BossFire").boss_showup.disconnect(_boss_encounter)

func bo_chay():
	isBossAlive = false
	boss_ins.get_node("BossFire").boss_showup.disconnect(_boss_encounter)
	score = score / 2
	boss_ins.get_node("BossFire").queue_free()


