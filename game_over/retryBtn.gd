extends Button

func _ready():
	grab_focus()

func _on_RetryBtn_pressed():
	get_node("/root/game_data").goto_scene("res://levels/game/game.tscn")
