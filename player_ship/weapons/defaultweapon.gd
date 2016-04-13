extends Area2D

# member variables here, example:

var activated = true
var screen_size
var timer=0
var canshoot = false

func _process(delta):
	
	
	
	if (activated):
		if Input.is_action_pressed("shoot"):
			
			shoot(delta)
		else:
			timer=0
			canshoot=false



func shoot(delta):
	if(canshoot):
		canshoot=false
		timer=0.5
	if(timer<0):
		print ("shoot")
		canshoot = true
	timer-=delta
	

func _ready():
	screen_size = get_viewport().get_rect().size
	set_process(true)
	pass


