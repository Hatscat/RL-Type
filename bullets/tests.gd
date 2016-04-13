
extends Node2D


func _ready():
	get_node("bullets_emitter").emit_bullets(30)
