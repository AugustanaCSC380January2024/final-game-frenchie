extends CharacterBody2D

@export var gravity = 1000
@export var jump_force = 500

@onready var player_sprite = $AnimatedSprite2D
@onready var runningmotion = $Running
@onready var rollingmotion = $Rolling

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
	if is_on_floor() && (Input.is_action_just_pressed("jump")):
		jump(jump_force)
	if is_on_floor() && (Input.is_action_pressed("rolling")):
		rolling()
	
	move_and_slide()
	update_animations()
	
func update_animations():
	if is_on_floor():
		if Input.is_action_pressed("rolling"):
			player_sprite.play("rolling")
		else:
			player_sprite.play("running")
	else:
		if velocity.y  < 0:
			player_sprite.play("jump")
		else:
			player_sprite.play("fall")
			
func jump(force):
	velocity.y = -force
	
func rolling():
	runningmotion.disabled = true
	rollingmotion.disabled = false
func _ready():
	pass
