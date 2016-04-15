
extends Node2D

var signals_emitter
var game_data

func _ready():
	game_data = get_node("/root/game_data")
	signals_emitter = get_node("/root/events_emitter")
	signals_emitter.connect("lets_spawn_enemy_wave", self, "spawn_enemy_wave", [])


func spawn_enemy_wave(enemy_types_arr):
	print("> spawn_enemy_wave: ", enemy_types_arr)
	for i in range(enemy_types_arr.size()):
		if enemy_types_arr[i] > 0:
			var new_path = game_data.enemy_paths[i].instance()
			add_child(new_path)
			new_path.emit_enemies(enemy_types_arr[i])