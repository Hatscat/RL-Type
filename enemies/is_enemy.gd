
extends Area2D

func is_enemy():
	pass

func on_bullet_hit(damage):
	get_parent().take_damage(damage)