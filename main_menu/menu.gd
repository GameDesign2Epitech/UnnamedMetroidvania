extends Control

export var scene_to_load : String

func _ready():
	pass 

func _on_play():
	scene_loader.goto_scene(scene_to_load)

func _on_quit():
	get_tree().quit()
