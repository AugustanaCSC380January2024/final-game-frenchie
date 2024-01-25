extends Area2D

@export var speed = 300
signal died


func _physics_process(delta):
	global_position.x += -speed * delta
	
func die():
	emit_signal("died")
	queue_free()	


func _on_body_entered(body):
	if body.name == "Billy" || body.name == "Rosie":
		Music.play_sfx("death")
		body.died()
