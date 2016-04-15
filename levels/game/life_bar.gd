extends TextureProgress

func _ready():
	get_node("/root/events_emitter").connect("player_hit", self, "_on_life_change")
	get_node("/root/events_emitter").connect("player_death", self, "_on_player_death")

func _on_life_change(dammage):
	var player = get_node("/root/game_data").player
	set_value(float(player.life)/float(player.max_life))
	
func _on_player_death():
	hide()