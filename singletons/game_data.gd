extends Node

var score = 0
var player = null
var enemy_paths = [
	preload("res://enemies/paths/astero_cat_1.tscn"),
	preload("res://enemies/paths/astero_cat_2.tscn"),
	preload("res://enemies/paths/astero_cat_3.tscn")
]
var enemy_types_nb = 3 #enemy_path.size()


func add_score(additional_score):
	score += additional_score
	get_node("/root/events_emitter").emit_signal("score_changed", score)
