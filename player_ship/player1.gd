
extends Area2D

# member variables here
export var speed = 200
export var max_life = 100

var life = 0
var screen_size
var current_weapon
var weapon_pos 

func _process(delta):
	
	var motion = Vector2()
	if(Input.get_joy_axis(0, 1) > 0.15 || Input.get_joy_axis(0, 1) < -0.15):
		motion += Vector2(0, Input.get_joy_axis(0, 1))
		get_node("propulsion").set_rot(deg2rad(0));
	else:
		if(Input.is_action_pressed("move_up")):
			motion += Vector2(0, -1)
			get_node("propulsion").set_rot(deg2rad(45))
			get_node("propulsion1").set_rot(deg2rad(45))
		else:
			get_node("propulsion").set_rot(deg2rad(0))
			get_node("propulsion1").set_rot(deg2rad(0))
		if(Input.is_action_pressed("move_down")):
			motion += Vector2(0, 1)
			get_node("propulsion").set_rot(deg2rad(-45))
			get_node("propulsion1").set_rot(deg2rad(-45))
	if(Input.get_joy_axis(0, 0) > 0.15 || Input.get_joy_axis(0, 0) < -0.15):
		motion += Vector2(Input.get_joy_axis(0, 0), 0)
	else:
		if(Input.is_action_pressed("move_left")):
			motion += Vector2(-1, 0)
		elif(Input.is_action_pressed("move_right")):
			motion += Vector2(1, 0)

	
	var pos = get_pos()
	pos += motion*speed*delta
	
	if (pos.x < 0):
		pos.x = 0
	if (pos.x > screen_size.x):
		pos.x = screen_size.x
	if (pos.y < 0):
		pos.y = 0
	if (pos.y > screen_size.y):
		pos.y = screen_size.y
		
	set_pos(pos)

func _ready():
	life = max_life
	weapon_pos = get_node("weapon_pos").get_pos()
	screen_size = get_viewport().get_rect().size
	get_node("propulsion").get_node("anim").play("burn")
	get_node("propulsion1").get_node("anim").play("burn")
	
	get_node("/root/game_data").player = self
	set_process(true)


func _on_player_area_enter( area ):
	if(area != current_weapon && area.has_method("is_weapon")):
		if(current_weapon != null):
			remove_child(current_weapon)
			current_weapon.on_dropped()
		
		current_weapon = area
		current_weapon.on_picked()
		add_child(current_weapon)
		current_weapon.set_pos(weapon_pos)
		
func on_bullet_hit(damage):
	life -= damage
	get_node("/root/events_emitter").emit_signal("player_hit", damage)
	check_life()
	
func check_life():
	if(life <= 0):
		get_node("/root/events_emitter").emit_signal("player_death")
		#get node explosion . play
		set_process(false)
		hide()
		life = 9000 #to prevent new death (yes this is ugly)

func is_player():
	pass