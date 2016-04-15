
extends Node2D


func _ready():
	get_node("bpattern_center/bullets_emitter").emit_bullets(10)