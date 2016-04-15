
extends Label

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("/root/events_emitter").connect("player_death", self, "on_player_death")

func on_player_death():
	var data = get_node("/root/game_data")
	data.player_scores.append(data.score)
	data.player_scores.sort()
	
	set_text("RANK: #" + str(data.player_scores.size() - data.player_scores.find(data.score) ) )