extends Area2D
@export var speed = 350

func _physics_process(delta):
	global_position.x += -speed * delta
	
func die():
	queue_free()
