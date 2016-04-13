
extends Node2D


export(String) var root_node_name = "Node2D"
# bullets config
export(int) var bullet_min_speed = 100
export(int) var bullet_max_speed = 400
export(float) var bullet_direction_deg = 0
export(bool) var bullet_stick_target = false
export(Texture) var bullet_sprite = preload("res://bullets/bullet_ball.png")
export(Color, RGBA) var bullet_color = null
export(Vector2) var bullet_scale = Vector2(1, 1)
export(String) var bullet_anim_name = null
export(float) var bullet_anim_speed = 1
# shape config
export(bool) var close_shape = false
export(int) var shape_speed = 0
export(float) var shape_direction_deg = 0
export(String) var shape_anim_name = null
export(float) var shape_anim_speed = 1
# private vars
var shape = null
var shape_origin_pos
var shape_anim
var shape_direction
var bullets = []


func _ready():
	shape = get_node("shape")
	if shape != null:
		shape_origin_pos = shape.get_pos()
	set_process(true)


func _process(delta):
	if shape != null:
		shape_direction = deg2rad(shape_direction_deg)
		shape.translate(Vector2(cos(shape_direction), sin(-shape_direction)) * shape_speed * delta)
		var target_pts = get_shape_pts(get_shape_polygons(), bullets.size())
		for i in range(bullets.size()):
			if bullets[i] != null:
				bullets[i].target = target_pts[i]


func emit_bullets(bullets_nb, total_duration=0, bullets_groups=null): # todo: + intervales
	var Bullet = preload("res://bullets/bullet.tscn")
	# shape points setup
	var target_pts = null
	if shape != null:
		shape.set_pos(shape_origin_pos)
		shape_anim = get_node("shape/anim")
		if shape_anim != null:
			shape_anim.play(shape_anim_name)
			shape_anim.seek(0)
			shape_anim.set_speed(shape_anim_speed)
		target_pts = get_shape_pts(get_shape_polygons(), bullets_nb)
	# bullets setup
	for i in range(bullets_nb):
		var b = Bullet.instance()
		bullets.append(b)
		b.set_pos(get_global_pos())
		b.min_speed = bullet_min_speed
		b.max_speed = bullet_max_speed
		b.speed = b.max_speed
		b.direction = deg2rad(bullet_direction_deg)
		if target_pts != null:
			b.target = target_pts[i]
			b.stick_target = bullet_stick_target
		b.tween_type = null #todo
		b.anim_name = bullet_anim_name
		b.anim_speed = bullet_anim_speed
		b.sprite = bullet_sprite
		b.color = bullet_color
		b.scale = bullet_scale
		b.emitter = self
		get_tree().get_root().get_node(root_node_name).add_child(b)


func get_shape_polygons():
	if shape == null:
		return null
	var polygons = shape.get_polygon()
	for i in range(polygons.size()):
		polygons[i] *= shape.get_scale()
		var poly_angle = atan2(polygons[i].y, polygons[i].x) - shape.get_rot()
		var poly = Vector2(cos(poly_angle), sin(poly_angle)) * polygons[i].length()
		var shape_off = shape.get_offset() * shape.get_scale()
		var offset_angle = atan2(shape_off.y, shape_off.x) - shape.get_rot()
		var offset = Vector2(cos(offset_angle), sin(offset_angle)) * shape_off.length()
		polygons[i] = get_pos() + shape.get_pos() + poly + offset
	return polygons


func get_shape_pts(polygons, points_nb):
	var pts = []
	for i in range(points_nb):
		var relative_pos = ((i + 0.0) / points_nb) * polygons.size()
		var idx = floor(relative_pos)
		var k = relative_pos - idx
		var idx1 = 0
		if idx < polygons.size() - 1:
			idx1 = idx + 1
		elif not close_shape:
			idx1 = idx
		pts.append(Vector2(lerp(polygons[idx].x, polygons[idx1].x, k), lerp(polygons[idx].y, polygons[idx1].y, k)))
	return pts


func remove_bullet(ref):
	if bullets != null and ref in bullets:
		bullets.erase(ref)