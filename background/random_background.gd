
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
export var textures = [ preload("res://background/background_1.png"), preload("res://background/background_2.png"), preload("res://background/background_3.png") ]

func _ready():
	randomize()
	set_texture(textures[randi() % textures.size()])


