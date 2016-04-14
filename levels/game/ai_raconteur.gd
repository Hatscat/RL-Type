	
extends Timer


var time_counter = 0
var player_threat = 0
var game_data
var events_emitter


func _ready():
	game_data = get_node("/root/game_data")
	events_emitter = get_node("/root/events_emitter")
	events_emitter.connect("enemy_destroyed", self, "enemy_destroyed", [1])
	events_emitter.connect("enemy_get_away", self, "enemy_get_away", [1])
	events_emitter.connect("player_hit", self, "player_hit", [0])
	set_process(true)
	enemies_wave()
	set_wait_time(1)
	start()


func _process(delta):
	time_counter += delta


func reset():
	time_counter = 0


func get_threat():
	return floor(time_counter) # linear to start


func enemies_wave():
	yield(self, "timeout")
	var threat = get_threat()
	print("enemy wave!  ", threat)
	events_emitter.emit_signal("lets_spawn_enemy_wave", get_enemy_wave_array(threat))
	set_wait_time(1)
	pass


func get_enemy_wave_array(threat):
	var enemy_wave_array = []
	while threat > 0:
		var enemy_val = randi() % game_data.enemy_types_nb
		if enemy_val > threat:
			enemy_val = threat
		enemy_wave_array.append(enemy_val)
		threat -= enemy_val
	return enemy_wave_array


func enemy_destroyed(enemy_type):
	player_threat += enemy_type
	game_data.add_score(24 + enemy_type * enemy_type * 42)


func enemy_get_away(enemy_type):
	pass


func player_hit(dammages):
	player_threat -= 1 #((dammages + 0.0) / player_max_hp) * game_data.enemy_types_nb
