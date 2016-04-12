
extends Node2D

export(String) var root_node_name = "Node2D"
export(String) var bullet_anim_name = null
export(int) var bullet_min_speed = 100
export(int) var bullet_max_speed = 400
export(float) var bullet_direction = 0


func _ready():
	pass


func _process(delta):
	pass


func emit_bullets(nb):
	var Bullet = preload("res://bullets/bullet.tscn")
	print("test:", Bullet)
	for i in range (nb):
		var b = Bullet.instance()
		b.set_pos(get_global_pos())
		b.min_speed = bullet_min_speed
		b.max_speed = bullet_max_speed
		b.speed = b.max_speed
		b.direction = bullet_direction
		b.target = null #Vector2(randf() * get_viewport_rect().size.x, randf() * get_viewport_rect().size.y)
		b.tween_type = null
		b.anim_name = null #"sin"
		b.anim_speed = 4
		#get_parent().add_child(b)
		get_tree().get_root().get_node(root_node_name).add_child(b)
