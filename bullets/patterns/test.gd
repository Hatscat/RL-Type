
extends Node2D


func _ready():
	get_node("bpattern_heart/bullets_emitter").emit_bullets(30, 2)