
extends Node2D


func _ready():
	get_node("bpattern_pacman/bullets_emitter").emit_bullets(40, 1)
