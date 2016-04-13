
extends Node2D

var emmiter

func _ready():
	emmiter = get_node("Emmiter")

func shot():
	emmiter.emit_bullets(10)

