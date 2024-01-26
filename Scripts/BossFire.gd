extends CharacterBody2D

@export var gravity = 10000

func _physics_process(delta):
	velocity.y = delta * gravity
	move_and_slide()
