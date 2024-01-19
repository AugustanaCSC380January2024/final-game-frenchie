extends Node2D


var segments = [
	preload("res://Scenes/shape_1.tscn"),
	preload("res://Scenes/shape_2.tscn"),
	preload("res://Scenes/shape_3.tscn"),
	preload("res://Scenes/shape_4.tscn")
	]
var speed = 200

func _ready():
	randomize()
	spawn_inst(0, 0)
	spawn_inst(1024, 0)

func _physics_process(delta):
	for area in $Areas.get_children():
		area.position.x -= speed*delta
		
func spawn_inst(x, y):
	var inst = segments[randi() % len(segments)].instantiate()
	inst.position = Vector2(x, y)
	$Areas.add_child(inst)
