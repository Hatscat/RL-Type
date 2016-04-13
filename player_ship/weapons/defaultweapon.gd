extends Area2D

export var cooldown = 0
var timer = 0
var canshoot = true
var weapon

func _process(delta):
	if Input.is_action_pressed("shoot") && canshoot:
		weapon.shot()
		canshoot = false
		timer = cooldown
		
	if(timer <= 0):
		canshoot = true
	else:
		timer -= delta

func _ready():
	weapon = get_node("Weapon")
	
func _on_picked():
	set_process(true)

func _on_droped():
	set_process(false)


