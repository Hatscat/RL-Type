extends TextureProgress

func _ready():
	get_node("/root/events_emitter").connect("player_hit", self, "_on_life_change")

func _on_life_change(life):
	set_value(life)