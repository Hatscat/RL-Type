extends Node2D

export(float) var cooldown = 0
var timer = 0
var canshoot = true
var weapon
var player_anim

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if canshoot:
			player_anim.play("fire")
			weapon.shot()
			canshoot = false
			timer = cooldown
	else:
		player_anim.stop(true)
	
	if(timer <= 0):
		canshoot = true
	
	timer -= delta

func _ready():
	weapon = get_node("Behaviour")
	player_anim = get_node("/root/game_data").player.get_node("fire").get_node("anim")
	get_node("/root/events_emitter").connect("player_death", self, "on_player_death")
	
func on_picked():
	get_parent().remove_child(self)
	set_process(true)
	get_node("Icon").hide()

func on_droped():
	set_process(false)
	get_node("Icon").show()

func on_player_death():
	set_process(false)

func is_weapon():
	pass

