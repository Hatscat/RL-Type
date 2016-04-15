
extends Node2D


func _ready():
	get_node("bpattern_tripleshot/bullets_emitter_1").emit_bullets(30, 2)
	get_node("bpattern_tripleshot/bullets_emitter_2").emit_bullets(30, 2)
	get_node("bpattern_tripleshot/bullets_emitter_3").emit_bullets(30, 2)
