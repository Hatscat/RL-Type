extends Node2D

export(float) var cooldown = 0
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
	weapon = get_node("Behaviour")
	
func on_picked():
	get_parent().remove_child(self)
	set_process(true)
	get_node("Icon").hide()

func on_droped():
	set_process(false)
	get_node("Icon").show()

func is_weapon():
	pass

