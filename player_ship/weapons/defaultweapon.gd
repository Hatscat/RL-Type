extends Area2D

# member variables here, example:
var prev_shooting = false
var activated = true
var screen_size

func _process(delta):
	
	
	
	if (activated):
		
		var shooting = Input.is_action_pressed("shoot")
		shoot(shooting)
		

func shoot(shooting):
	
	if (shooting and not prev_shooting):
		print ("shoot")
	
	
	prev_shooting = shooting

func _ready():
	screen_size = get_viewport().get_rect().size
	set_process(true)
	pass


