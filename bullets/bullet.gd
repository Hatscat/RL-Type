
extends Node2D


var hit = false
var min_speed = 200
var max_speed = 200
var speed = min_speed
var direction = 0
var target = null
var tween_type = null
var anim_name = null
var anim_speed = null


#func setup(_min_speed, _max_speed, _direction=0, _target=null, _tween_type=null, _anim_name=null, _anim_speed=null):
#	min_speed = _min_speed
#	max_speed = _max_speed
#	speed = min_speed #tmp?
#	direction = _direction
#	print(direction)
#	set_rot(direction)
#	target = _target
#	tween_type = _tween_type
#	anim_name =_anim_name
#	anim_speed = _anim_speed


func _ready():
	set_rot(direction)
	if tween_type != null:
		pass #todo
	if anim_name != null:
		get_node("Area2D/Anim").play(anim_name)
		if anim_speed != null:
			get_node("Area2D/Anim").set_speed(anim_speed)
	set_process(true)
	

func _process(delta):
	if target != null:
		var dir = target - get_global_pos()
		set_rot(atan2(get_pos().y - target.y, target.x - get_pos().x))
		if (dir.length_squared() > 2):
			translate(dir.normalized() * speed * delta)
		else:
			get_node("Area2D/Anim").stop_all()
	else:
		translate(Vector2(cos(direction), sin(-direction)) * speed * delta)


func _on_visibility_exit_screen():
	queue_free()


func _hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	#get_node("Area2D/Anim").play("splash") #todo


func _on_shot_area_enter(area):
	if (area.has_method("destroy")):
		area.destroy()
		_hit_something()
