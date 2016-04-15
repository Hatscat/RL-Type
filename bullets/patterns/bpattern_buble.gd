
extends Node2D


func _ready():
	get_node("bpattern_buble/bullets_emitter").emit_bullets(20, 2)
