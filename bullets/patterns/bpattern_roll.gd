
extends Node2D


func _ready():
	get_node("bpattern_roll/bullets_emitter").emit_bullets(20)