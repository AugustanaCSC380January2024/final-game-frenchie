extends Control

@onready var player_progress_bar = $PlayerPanel/PlayerData/ProgressBar
@onready var boss_progress_bar = $BossContainer/ProgressBar
@onready var uilayer = $".."
@onready var forfeitloser = $"../GameOver"

@export var enemy: Resource = null

var current_player_health = 0
var current_boss_health = 0
var is_defending = false

func _ready():
	current_player_health = Game.current_health
	current_boss_health = enemy.health
	
	set_health(boss_progress_bar, enemy.health, enemy.health)
	set_health(player_progress_bar, Game.current_health, Game.max_health)
	$TextBox.hide()
	$ActionPanel.hide()
	display_text("I shall crush you to pieces!")

func display_text(text):
	$TextBox.show()
	$TextBox/Text.text = text

func _input(event):
	if (Input.is_action_just_pressed("ui_accept")) and $TextBox.visible:
		$TextBox.hide()
		$ActionPanel.show()


func _on_forfeit_pressed():
	display_text("You coward!!")
	Music.play_sfx("forfeit")
	await get_tree().create_timer(2).timeout
	$TextBox.hide()
	self.visible = false
	forfeitloser.set_high_score("No one remembers a cowardly knight...")
	uilayer.show_game_over(true)
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	


func _on_attack_pressed():
	display_text("Die you horrid creature!")
	await get_tree().create_timer(1).timeout
	Music.play_sfx("attack")
	$TextBox.hide()
	current_boss_health = max(0, current_boss_health - Game.damage)
	set_health(boss_progress_bar, current_boss_health, enemy.health)
	await get_tree().create_timer(1).timeout
	display_text("You dealth %d damage!" % Game.damage)
	await get_tree().create_timer(2).timeout
	$TextBox.hide()
	
	if current_boss_health == 0:
		display_text("MIKANOS is slained")
		Music.play_sfx("bossdeath")
		await get_tree().create_timer(2).timeout
		display_text("No... This can't be...")
		await get_tree().create_timer(3).timeout
		get_tree().quit()
	enemy_turn()

func enemy_turn():
	await get_tree().create_timer(1).timeout
	display_text("Rahahaha is that all you got?")
	await get_tree().create_timer(1).timeout
	Music.play_sfx("bossattack")
	$TextBox.hide()
	
	if is_defending:
		is_defending = false
		$AnimationPlayer.play("mini_shake")
		await get_tree().create_timer(1).timeout
		display_text("You bravely defended the attack")
		await get_tree().create_timer(1).timeout
		$TextBox.hide()
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health(player_progress_bar, current_player_health, Game.max_health)
		$AnimationPlayer.play("shake")
		await get_tree().create_timer(1).timeout
		display_text("%s dealth %d damage!" % [enemy.name, enemy.damage])
		await get_tree().create_timer(1).timeout
		$TextBox.hide()
		
	if current_player_health == 0:
		display_text("You are defeated")
		await get_tree().create_timer(2).timeout
		display_text("I am too young... too too young...")
		await get_tree().create_timer(2).timeout
		


func _on_defend_pressed():
	is_defending = true
	await get_tree().create_timer(1).timeout
	display_text("My shield shall yield!")
	await get_tree().create_timer(2).timeout
	enemy_turn()
