
extends AnimationPlayer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	randomize()
	var speed = rand_range(1,4)
	set_speed(speed)
	pass


