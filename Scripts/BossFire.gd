extends CharacterBody2D

@export var gravity = 10000

func _physics_process(delta):
	velocity.y = delta * gravity
	move_and_slide()


func _on_fight_body_entered(body):
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/bossfight.tscn")
