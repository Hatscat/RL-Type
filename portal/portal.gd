
extends Node2D

func _ready():
	get_node("/root/events_emitter").connect("portal_entered", self, "_teleport")
	pass

func _teleport():
	get_node("/root/scenes_manager").goto_scene("res://levels/game/game.tscn")


