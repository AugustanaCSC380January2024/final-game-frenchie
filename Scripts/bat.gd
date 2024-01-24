extends Area2D

@export var speed = 300
signal died


func _physics_process(delta):
	global_position.x += -speed * delta
	
func die():
	emit_signal("died")
	queue_free()	



func _on_hurt_box_area_entered(area):
	if area.name == "HitBox": return
	$HitBox.set_deferred("monitorable", false)
	queue_free()
