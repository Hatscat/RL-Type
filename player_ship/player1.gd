
extends Area2D

# member variables here
export var SPEED = 200

var screen_size
var prev_shooting = false
var killed = false



func _process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1.5)
	if Input.is_action_pressed("move_down"):
		motion += Vector2(0, 1.5)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-2.25, 0)
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1.5, 0)
	
	
	var pos = get_pos()
	
	pos += motion*delta*SPEED
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
	get_node("propulsion").get_node("anim").play("burn")
	get_node("propulsion1").get_node("anim").play("burn")
	screen_size = get_viewport().get_rect().size
	set_process(true)
