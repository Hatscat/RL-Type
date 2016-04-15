
extends Node2D


func _ready():
	get_node("bpattern_triplestar/bullets_emitter_1").emit_bullets(30)
	get_node("bpattern_triplestar/bullets_emitter_2").emit_bullets(30)
	get_node("bpattern_triplestar/bullets_emitter_3").emit_bullets(30)
