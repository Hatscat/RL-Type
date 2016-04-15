
extends Node2D


func _ready():
	get_node("bpattern_shiningstar/bullets_emitter").emit_bullets(30)