
extends AnimationPlayer


func _ready():
	get_node("/root/events_emitter").connect("player_death", self, "on_player_death")

func on_player_death():
	play("GameOver")
