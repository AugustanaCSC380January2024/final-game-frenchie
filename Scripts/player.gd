extends CharacterBody2D

@export var gravity = 1000
@export var jump_force = 500

@onready var player_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
	if is_on_floor():	
		if Input.is_action_pressed("jump"):
			velocity.y = -jump_force
	
	move_and_slide()
func _ready():
	pass
