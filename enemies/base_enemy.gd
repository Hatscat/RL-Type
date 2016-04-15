extends Node2D

export(float) var cooldown = 0
export(float) var bullets_nb = 1
export(float) var total_time = 0

export(String) var patern_name 
var timer = 0
var canshoot = true
var weapon

func _process(delta):
	if !get_parent().is_active:
		return
	if canshoot:
		weapon.emit_bullets(bullets_nb, total_time)
		canshoot = false
		timer = cooldown
		
	if(timer <= 0):
		canshoot = true
	else:
		timer -= delta

func _ready():
	weapon = get_node(patern_name)
	set_process(true)

func is_weapon():
	pass


