
extends Node2D

func _ready():
	pass

func _teleport():
	get_node("/root/scenes_manager").goto_scene("res://levels/game/game.tscn")

func _on_Area2D_area_enter( area ):
	if(area.has_method("is_player")):
		_teleport()
