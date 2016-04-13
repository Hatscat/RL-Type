
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
var color = null


func _ready():
	set_rot(direction)
	if color != null:
		get_node("Area2D/Sprite").set_modulate(color)
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
		if (dir.length_squared() > 8):
			translate(dir.normalized() * speed * delta)
		#else:
		#	get_node("Area2D/Anim").stop_all()
	else:
		translate(Vector2(cos(direction), sin(-direction)) * speed * delta)


func _on_visibility_exit_screen():
	print("good bye!")
	queue_free()


func _hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	get_node("Area2D/Anim").play("explode")


func _on_shot_area_enter(area):
	if (area.has_method("destroy")):
		area.destroy()
		_hit_something()
