
extends Node2D


# private vars
var hit = false
var is_free = false
# public vars
var damages = 1
var min_speed = 200
var max_speed = 200
var speed = max_speed
var direction = 0
var target = null
var stick_target = false
var tween_type = null
var anim_name = null
var anim_speed = null
var sprite = null
var color = null
var scale = null
var emitter = null


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
	get_node("Area2D").connect("area_enter", self, "_on_shot_area_enter")
	set_process(true)


func _process(delta):
	var sd = speed * delta
	if target != null and not is_free:
		var dir = target - get_global_pos()
		if (dir.length_squared() <= sd * sd):
			if stick_target:
				set_pos(target)
			else:
				is_free = true
		else:
			direction = atan2(get_pos().y - target.y, target.x - get_pos().x)
			set_rot(direction)
			translate(dir.normalized() * sd)
	else:
		translate(Vector2(cos(direction), sin(-direction)) * sd)


func _on_visibility_exit_screen():
	if emitter != null and emitter.has_method("remove_bullet"):
		emitter.remove_bullet(self)
	queue_free()


func _hit_something():
	if hit:
		return
	hit = true
	set_process(false)
	get_node("Area2D/Anim").play("explode")


func _on_shot_area_enter(area):
	if hit or area.has_method("is_bullet") or area.has_method("is_weapon"):
		return
	if area.has_method("on_bullet_hit"):
		area.on_bullet_hit(damages)
	_hit_something()
	
