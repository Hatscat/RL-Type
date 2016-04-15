
extends TextureButton


func _ready():
	pass

func _on_TextureButton1_pressed():
	get_node("/root/scenes_manager").goto_scene("res://levels/menu/menu.tscn")
