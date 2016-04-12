
extends Button


func _ready():
	pass

func _on_Menu_pressed():
	get_node("/root/game_data").goto_scene("res://levels/menu/menu.tscn")
