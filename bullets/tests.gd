
extends Node2D


func _ready():
	get_node("bullets_emitter_1").emit_bullets(30, 5)
	get_node("bullets_emitter_2").emit_bullets(30, 4)
	get_node("bullets_emitter_3").emit_bullets(30, 3)
