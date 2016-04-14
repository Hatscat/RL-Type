
extends Label

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("/root/events_emitter").connect("player_death", self, "on_player_death")

func on_player_death():
	set_text("SCORE: " + str(get_node("/root/game_data").score))
