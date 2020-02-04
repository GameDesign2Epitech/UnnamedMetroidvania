extends Node2D

export (PackedScene) var spike_scene
export (int) var width_left = 0
export (int) var width_right = 0

func _ready():
	$AnimatedSprite.visible = false
	var spike
	spike = spike_scene.instance()
	add_child(spike)
	spike.position = Vector2()
	for i in range(width_left):
		spike = spike_scene.instance()
		add_child(spike)
		spike.position.x = (i + 1) * 32
		spike.position.y = 0
	for i in range(width_right):
		spike = spike_scene.instance()
		add_child(spike)
		spike.position.x = (i + 1) * 32
		spike.position.y = 0
