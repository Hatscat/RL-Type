	
extends Timer


# config
#var time_weight

# private vars
var time_counter = 0
var player_threat = 3
var old_thread = 0
var game_data
var events_emitter


func _ready():
	game_data = get_node("/root/game_data")
	events_emitter = get_node("/root/events_emitter")
	events_emitter.connect("enemy_destroyed", self, "enemy_destroyed", [1])
	events_emitter.connect("enemy_get_away", self, "enemy_get_away", [1])
	events_emitter.connect("player_hit", self, "player_hit", [0])
	set_process(true)
	#enemies_wave()
	#set_wait_time(1)
	#start()


func _process(delta):
	time_counter += delta
	if get_threat() > old_thread:
		enemy_wave()


func reset():
	old_thread = get_threat() # += ?
	player_threat = 0
	time_counter = 0


func get_threat():
	return int(player_threat + floor(time_counter) * 1) # linear to start


func enemy_wave():
	#yield(self, "timeout")
	var threat = get_threat()
	print("enemy wave!  ", threat)
	var enemy_array = get_enemy_wave_array(threat)
	print("ennemies:  ", enemy_array)
	events_emitter.emit_signal("lets_spawn_enemy_wave", enemy_array)
	reset()
	#set_wait_time(1)
	#pass


func get_enemy_wave_array(threat): # todo: by types... [type 0, type 1, type 2, etc.]
	var enemy_wave_array = []
	var rnd = randf()
	var p = 1.0 / (game_data.enemy_types_nb * 1.5)
	for i in range(game_data.enemy_types_nb, 0, -1):
		if threat % i == 0 and randf() < p:
			for ii in range(0, threat, i):
				enemy_wave_array.append(i)
	if enemy_wave_array.size() > 0:
		return enemy_wave_array
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
	player_threat -= 1 # floor((dammages + 0.0) / game_data.player.max_hp) * game_data.enemy_types_nb)
