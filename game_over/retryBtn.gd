extends Button

func _ready():
	grab_focus()

func _on_RetryBtn_pressed():
	get_node("/root/scenes_manager").goto_scene("res://levels/game/game.tscn")
