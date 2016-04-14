
extends Timer


var time_counter = 0


func _ready():
	set_process(true)


func _process(delta):
	time_counter += delta


func reset():
	time_counter = 0


func get_threat_speed():
	return time_counter # linear to start
