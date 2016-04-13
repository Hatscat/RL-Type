extends Control

func _ready():
	get_node("PlayBtn").grab_focus()

func _on_PlayBtn_pressed():
	get_node("AnimationPlayer 2").connect("finished", self, "_exit_menu")
	get_node("AnimationPlayer 2").play("MenuExitAnim")

func _exit_menu():
	get_node("/root/scenes_manager").goto_scene("res://levels/game/game.tscn")
	