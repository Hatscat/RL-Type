extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("Button").grab_focus()

func _on_Button_pressed():
	get_tree().change_scene("res://levels/game/game.tscn")
