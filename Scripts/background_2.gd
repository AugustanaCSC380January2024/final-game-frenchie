extends ParallaxBackground

@onready var sprite = $ParallaxLayer/Sprite2D
@export var scroll_speed = 15
@export var bg_tex: CompressedTexture2D = preload("res://Assets/craftpix-net-293214-ocean-and-clouds-free-pixel-art-backgrounds/Ocean_5/5.png")

func _ready():
	sprite.texture = bg_tex
func _process(delta):
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	if sprite.region_rect.position >= Vector2(2304, 1296):
		sprite.region_rect.position = Vector2.ZERO
