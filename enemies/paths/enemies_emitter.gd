
extends Node2D

export var threat_level = 1
var emitter

func _ready():
	emitter = get_node("bullets_emitter")
	get_node("bullets_emitter/Bullet").set_active(false)
	emit_enemies(5)

func emit_enemies(enemies_nb, total_duration=0, enemies_groups=null):
	emitter.emit_bullets(enemies_nb, total_duration, enemies_groups)
