
extends Node2D


# private vars
var is_free = false
var is_active = true
# public vars
export var damages = 1
export var max_speed = 200
export var is_enemy = false
export var max_life = 10
export(String) var anim_name = null
export(bool) var rotate_to_target = true
var min_speed = 200
var speed = 0
var direction = 0
var target = null
var stick_target = false
var tween_type = null
var anim_speed = null
var sprite = null
var color = null
var scale = null
var emitter = null
var life = 0
var sender

func _ready():
	life = max_life
	speed = max_speed
	if(is_enemy):
		sender = "is_enemy"
	else:
		sender = "is_player"
	
	set_rot(direction)
	if sprite != null:
		get_node("Area2D/Sprite").set_texture(sprite)
	if color != null:
		get_node("Area2D/Sprite").set_modulate(color)
	if scale != null:
		set_scale(scale)
	if tween_type != null:
		pass #todo
	if anim_name != null && get_node("Area2D/Anim") != null && get_node("Area2D/Anim").get_animation(anim_name) != null:
		get_node("Area2D/Anim").play(anim_name)
		get_node("Area2D/Anim").seek(randf() * get_node("Area2D/Anim").get_animation(anim_name).get_length())
		if anim_speed != null:
			get_node("Area2D/Anim").set_speed(anim_speed)
	set_process(true)
	get_node("Area2D").connect("area_enter", self, "_on_area_enter")



func _process(delta):
	var sd = speed * delta
	if target != null and not is_free:
		var dir = target - get_global_pos()
		if dir.length_squared() <= sd * sd:
			if stick_target:
				set_pos(target)
			else:
				is_free = true
		else:
			direction = atan2(get_pos().y - target.y, target.x - get_pos().x)
			translate(dir.normalized() * sd)
			if rotate_to_target:
				set_rot(direction)
	else:
		translate(Vector2(cos(direction), sin(-direction)) * sd)

func _on_visibility_exit_screen():
	if emitter != null and emitter.has_method("remove_bullet"):
		emitter.remove_bullet(self)
	queue_free()


func explode():
	is_active = false
	queue_free()
	set_process(false)
	#get_node("Area2D/Anim").play("explode")


func _on_area_enter(area):
	if (!is_active || area.has_method("is_weapon") || area.has_method("is_bullet") || area.has_method(sender) ) :
		return

	if area.has_method("on_bullet_hit"):
		area.on_bullet_hit(damages)

	take_damage(life)

func set_active(_bool):
	if _bool:
		show()
	else: 
		hide()
	
	set_process(_bool)
	is_active = _bool
	
func take_damage(damage):
	life -= damage
	if(is_active && life <= 0):
		explode()