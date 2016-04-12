
extends Label

func _ready():
	get_node("/root/game_data").connect("score_changed", self, "_on_score_change")

func _on_score_change(score):
	
	set_text("Score: " +  str(score))
