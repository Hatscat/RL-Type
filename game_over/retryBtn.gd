extends TextureButton

func _ready():
	get_node("/root/events_emitter").connect("player_death", self, "on_player_death")

func on_player_death():
	grab_focus()

func _on_TextureButton_pressed():
	get_node("/root/scenes_manager").goto_scene("res://levels/game/game.tscn")
