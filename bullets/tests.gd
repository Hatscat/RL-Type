
extends Node2D


func _ready():
	get_node("bullets_emitter_1").emit_bullets(30)
	get_node("bullets_emitter_2").emit_bullets(33)
