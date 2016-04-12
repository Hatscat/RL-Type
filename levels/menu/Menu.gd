extends Control

var score = 0

func _ready():
	get_node("Button").grab_focus()

func _on_Button_pressed():
	get_node("/root/game_data").goto_scene("res://levels/game/game.tscn")
