
extends Node2D


func _ready():
	get_node("bpattern_triplewave2/bullets_emitter").emit_bullets(20, 2, [10, 10])