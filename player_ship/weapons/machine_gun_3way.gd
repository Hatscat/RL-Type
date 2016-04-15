
extends Node2D

var emmiter1
var emmiter2
var emmiter3

func _ready():
	emmiter1 = get_parent().get_node("bpattern_3way/bullets_emitter_1")
	emmiter2 = get_parent().get_node("bpattern_3way/bullets_emitter_2")
	emmiter3 = get_parent().get_node("bpattern_3way/bullets_emitter_3")

func shot():
	emmiter1.emit_bullets(1)
	emmiter2.emit_bullets(1)
	emmiter3.emit_bullets(1)