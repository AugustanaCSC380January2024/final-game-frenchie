extends CharacterBody2D

@export var gravity = 1000
@export var jump_force = 550

signal rosiedie
@onready var ray = $RayCast2D
@onready var player_sprite = $AnimatedSprite2D
@onready var runningmotion = $Running
@onready var dehorsemotion = $WithoutHorse
@onready var player_camera = $Camera2D

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
	if is_on_floor() && (Input.is_action_just_pressed("jump")):
		jump(jump_force)
	if is_on_floor() && (Input.is_action_just_pressed("rolling")):
		rolling()
	
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
			player_sprite.play("dehorse")
		else:
			player_sprite.play("running")
			runningmotion.disabled = false
			dehorsemotion.disabled = true
	else:
		if velocity.y  < 0:
			player_sprite.play("jumping")
		else:
			player_sprite.play("fall")
			
func jump(force):
	velocity.y = -force
	
func rolling():
	runningmotion.disabled = true
	dehorsemotion.disabled = false
func _ready():
	pass

func died():
	emit_signal("rosiedie")
	queue_free()

func _on_head_box_body_entered(body):
	velocity.y = max(velocity.y, 0)
