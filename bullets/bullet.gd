
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
var sprite = null
var color = null
var scale = null


func _ready():
	set_rot(direction)
	if sprite != null:
		get_node("Area2D/Sprite").set_texture(sprite)
	if color != null:
		get_node("Area2D/Sprite").set_modulate(color)
	if scale != null:
		set_scale(scale)
	if tween_type != null:
		pass #todo
	if anim_name != null:
		get_node("Area2D/Anim").play(anim_name)
		get_node("Area2D/Anim").seek(randf() * get_node("Area2D/Anim").get_animation(anim_name).get_length())
		if anim_speed != null:
			get_node("Area2D/Anim").set_speed(anim_speed)
	set_process(true)
	

func _process(delta):
	if target != null:
		var dir = target - get_global_pos()
		if (dir.length_squared() < 2):
			set_pos(target)
		else:
			set_rot(atan2(get_pos().y - target.y, target.x - get_pos().x))
			translate(dir.normalized() * speed * delta)
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
