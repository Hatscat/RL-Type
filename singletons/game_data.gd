extends Node

var score = 0
var player_scores = []
var player = null
var enemy_paths = [
	preload("res://enemies/paths/astero_cat_1.tscn"),
	preload("res://enemies/paths/nyan_cat.scn"),
	preload("res://enemies/paths/grumpy.tscn"),
	preload("res://enemies/paths/lama.tscn"),
	preload("res://enemies/paths/putin.tscn"),
]
var enemy_types_nb = enemy_paths.size()


func add_score(additional_score):
	score += additional_score
	get_node("/root/events_emitter").emit_signal("score_changed", score)
