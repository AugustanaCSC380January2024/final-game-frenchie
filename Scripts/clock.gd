extends Area2D
@export var speed = 350
signal claimed
func _physics_process(delta):
	global_position.x += -speed * delta
	
func claim():
	emit_signal("claimed")
	queue_free()


func _on_body_entered(body):
	claim()
