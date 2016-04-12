
extends Label

func _ready():
	get_node("/root/events_emitter").connect("score_changed", self, "_on_score_change")
	get_node("/root/game_data").add_score(0)

func _on_score_change(score):
	set_text("Score: " +  str(score))
