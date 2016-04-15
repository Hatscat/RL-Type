
extends Area2D

# member variables here
export var speed = 200
export var max_life = 100

var life = 0
var screen_size
var current_weapon
var weapon_pos 
var propulsor
var propulsor1

func _process(delta):
	
	var motion = Vector2()
	if(Input.get_joy_axis(0, 1) > 0.15 || Input.get_joy_axis(0, 1) < -0.15):
		motion += Vector2(0, Input.get_joy_axis(0, 1))
		propulsor.set_rot(deg2rad(0));
		propulsor1.set_rot(deg2rad(0));
	else:
		if(Input.is_action_pressed("move_up")):
			motion += Vector2(0, -1)
			propulsor.set_rot(deg2rad(45))
			propulsor1.set_rot(deg2rad(45))
		else:
			propulsor.set_rot(deg2rad(0))
			propulsor1.set_rot(deg2rad(0))
		if(Input.is_action_pressed("move_down")):
			motion += Vector2(0, 1)
			propulsor.set_rot(deg2rad(-45))
			propulsor1.set_rot(deg2rad(-45))
	if(Input.get_joy_axis(0, 0) > 0.15 || Input.get_joy_axis(0, 0) < -0.15):
		motion += Vector2(Input.get_joy_axis(0, 0), 0)
	else:
		if(Input.is_action_pressed("move_left")):
			motion += Vector2(-1, 0)
			psize( propulsor, 80)
			psize( propulsor1, 80)
			print("lol")
		else:
			psize(propulsor, 125);
			psize(propulsor1, 125);
		if(Input.is_action_pressed("move_right")):
			motion += Vector2(1, 0)
			psize(propulsor, 200)
			psize(propulsor1, 200)


	
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

func spritecenter(sprite):
	# get sizes
	var screen_size = screensize()
	var texture_size = getsize(sprite)
	var fin_pos = Vector2(0,0)
 
	# center option checked?
	if sprite.is_centered():
		fin_pos = screen_size * 0.5
	else:
		fin_pos = screen_size * 0.5 - texture_size * 0.5
 
	# set pos
	sprite.set_global_pos( fin_pos )
 
 
# set size (screen border mode)
func sbsize(sprite, top = 0, right = 0, bottom = 0, left = 0):
	# get current size
	var screen_size = screensize()
 
	# calc
	if sprite.is_centered():
		screen_size.x -= (right + left)*2 # width
		screen_size.y -= (top + bottom)*2 # height
	else:
		screen_size.x -= (right + left) # width
		screen_size.y -= (top + bottom) # height
 
	#set pos
	spritecenter(sprite)
	if sprite.is_centered():
		sprite.set_global_pos( Vector2(  sprite.get_global_pos().x + (left - right), sprite.get_global_pos().y + (top - bottom) ) )
	else:
		sprite.set_global_pos( Vector2(  (left), (top)  ) )
 
	# set scale
	return setsize(sprite, screen_size.x, screen_size.y)
 
 
# set size (screen percent mode)
func spsize(sprite, percentwidth=100, percentheight=null):
	# get current size
	var screen_size = screensize()
 
	# get height and width
	var texture_size = getsize(sprite)
 
	# no width percent given?
	if !percentwidth > 0:
		return false
 
	# calc
	var targetwidth = screen_size.x * (percentwidth * 0.01)
 
	#set scale
	if percentheight:
		var targetheight = screen_size.y * (percentheight * 0.01)
		return setsize(sprite, targetwidth, targetheight)
	else:
		return setsize(sprite, targetwidth)
 
 
# set size (percent mode)
func psize(sprite, percentwidth=100, percentheight=null):
	# get current size
	var texture_size = getsize(sprite)
 
	# no percent given?
	if !percentwidth > 0:
		return false
	if !percentheight:
		percentheight = percentwidth
 
	# nothing to do?
	if percentwidth == 100 and percentheight == 100:
		return false
 
	# calc
	var targetwidth = texture_size.x * (percentwidth * 0.01)
	var targetheight = texture_size.y * (percentheight * 0.01)
 
	#set scale
	return setsize(sprite, targetwidth, targetheight)
 
 
# set size (pixel mode)
func setsize(sprite, width = "*", height = "*"):
	# get current size
	var texture_size = getsize(sprite)
 
	# no size given?
	if str( height ) == "" and str( width ) == "":
		return false
 
	# proportional resizing?
	if str( height ) == "*":
		height = texture_size.x / texture_size.y * width
	if str( width ) == "*":
		width = texture_size.y / texture_size.x * height
 
	# calculate scaling
	var finalscale = Vector2( width, height ) / texture_size
	sprite.set_scale( finalscale )
 
	return( finalscale )
 
 
# get size
func getsize(sprite):
	# return size
	return Vector2( sprite.get_texture().get_width() * sprite.get_scale().x, sprite.get_texture().get_height() * sprite.get_scale().y ) 
 
 
# get screen size
func screensize():
 
	var sizeA
	var sizeB
 
	# Root auslesen
	var root = get_tree().get_root()
	var current_scene = root.get_child( root.get_child_count() -1 )
 
	if current_scene.get_viewport_rect().size.x > 0:
		sizeA = current_scene.get_viewport_rect().size
	else:
		return OS.get_video_mode_size()
 
	sizeB = OS.get_video_mode_size()
 
	if sizeA < sizeB:
		return sizeA
	else:
		return sizeB

func _ready():
	life = max_life
	propulsor = get_node("ship/propulsion")
	propulsor1 = get_node("ship/propulsion1")
	weapon_pos = get_node("weapon_pos").get_pos()
	screen_size = get_viewport().get_rect().size
	get_node("ship/propulsion").get_node("anim").play("burn")
	get_node("ship/propulsion1").get_node("anim").play("burn")
	
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
		get_node("explosion").get_node("anim").play("explode")
		set_process(false)
		get_node("ship").hide()
		life = 9000 #to prevent new death (yes this is ugly)

func is_player():
	pass