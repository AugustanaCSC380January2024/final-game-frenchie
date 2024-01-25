extends CharacterBody2D

@export var gravity = 1000
@export var jump_force = 600

@onready var ray = $RayCast2D
@onready var player_sprite = $AnimatedSprite2D
@onready var runningmotion = $Running
@onready var rollingmotion = $Rolling
@onready var player_camera = $Camera2D
@onready var attackingmovement = $AttackingForce
@onready var gameoverscreen = $UILayer

signal playerdie

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
	if is_on_floor() && (Input.is_action_just_pressed("jump")):
		jump(jump_force)
	if is_on_floor() && (Input.is_action_just_pressed("rolling")):
		rolling()
	if Input.is_action_just_pressed("attack"):
		attacking()
		
	
	move_and_slide()
	update_animations()
	
func update_animations():
	if (ray.is_colliding()):
		var orig = ray.global_transform.origin
		var colli = ray.get_collision_point()
		var dist = abs(orig.y - colli.y)
		var depth = abs(ray.target_position.y - dist)
		
		position.y == depth
	if is_on_floor():
		if Input.is_action_pressed("rolling"):
			player_sprite.play("rolling")
		elif Input.is_action_pressed("attack"):
			attacking()
		else:
			player_sprite.play("running")
			runningmotion.disabled = false
			rollingmotion.disabled = true
	else:
		if velocity.y  < 0:
			if (Input.is_action_pressed("attack")):
				attacking()
			else:
				player_sprite.play("jump")
		else:
			if (Input.is_action_pressed("attack")):
				attacking()
			else:
				player_sprite.play("fall")
			
func jump(force):
	Music.play_sfx("jump")
	velocity.y = -force
	
func rolling():
	runningmotion.disabled = true
	rollingmotion.disabled = false
	
func attacking():
	Music.play_sfx("billyattack")
	player_sprite.play("attacking")
	attackingmovement.monitorable = true
	attackingmovement.monitoring = true
	attackingmovement.visible = true
	await get_tree().create_timer(0.8).timeout
	attackingmovement.monitorable = false
	attackingmovement.monitoring = false
	attackingmovement.visible = false
	
	
func died():
	emit_signal("playerdie")
	queue_free()
	
func _ready():
	pass


func _on_head_box_body_entered(body):
	velocity.y = max(velocity.y, 0)
		
	
func _on_attacking_force_area_entered(area):
	if area.name == "Bat" or "Area2D" in area.name:
		Music.play_sfx("batdeath")
		area.die()
