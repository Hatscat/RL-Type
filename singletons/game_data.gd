extends Node

var score = 0

func set_score(new_score):
	score = new_score
	get_node("/root/events_emitter").emit_signal("score_changed", score)
