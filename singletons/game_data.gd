extends Node

var score = 0
var enemy_types_nb = 3
var player = null

func add_score(additional_score):
	score += additional_score
	get_node("/root/events_emitter").emit_signal("score_changed", score)
