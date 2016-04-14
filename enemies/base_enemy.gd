
extends Node2D

export(int) var max_life = 100
export(int) var min_speed = 200
export(int) var max_speed = 200
var life = max_life

var direction = 0
var speed = max_speed
var target = null
var stick_target = false
var is_free = false

func _ready():
	get_node("Area2D").connect("area_enter", self, "on_area_enter")
	set_process(true)
	
func _process(delta):
	if target != null && !is_free:
		var dir = target - get_global_pos()
		if (dir.length_squared() <= sd * sd):
			if stick_target:
				set_pos(target)
			else:
				is_free = true
		else:
			direction = atan2(get_pos().y - target.y, target.x - get_pos().x)
			translate(dir.normalized() * sd)
	else:
		translate(Vector2(cos(direction), sin(-direction)) * sd)

func explode():
	#TODO anim
	set_process(false)
	hide()
	
func on_bullet_hit(damage):
	life -= damage
	if(life <= 0):
		explode()

func on_area_enter(area):
	if(area.has_method("is_player")):
		explode()
	if(area.has_method("on_enemy_hit")):
		area.on_enemy_hit()

#TODO bind signal
func _on_visibility_exit_screen():
	queue_free()

func is_enemy():
	pass