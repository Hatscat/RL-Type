extends Control

func _ready():
	get_node("Button").grab_focus()

func _on_Button_pressed():
	get_node("/root/scenes_manager").goto_scene("res://levels/game/game.tscn")
