tool
extends Node2D

export (PackedScene) var spike_scene
export (int) var width_left = 0 setget _set_width_left
export (int) var width_right = 0 setget _set_width_right

func _ready():
	if not Engine.editor_hint:
		$AnimatedSprite.visible = false
		var spike
		spike = spike_scene.instance()
		add_child(spike)
		spike.position = Vector2()
		for i in range(width_left):
			spike = spike_scene.instance()
			add_child(spike)
			spike.position.x = (i + 1) * -32
			spike.position.y = 0
		for i in range(width_right):
			spike = spike_scene.instance()
			add_child(spike)
			spike.position.x = (i + 1) * 32
			spike.position.y = 0
	else:
		_update_spawn()


func _set_width_left(_width_left):
	width_left = _width_left
	_update_spawn()


func _set_width_right(_width_right):
	width_right = _width_right
	_update_spawn()


func _clear_childs():
	var children = get_children()
	var children_count = get_child_count()
	for i in range(1, children_count):
		var child = children[i]
		remove_child(child)
		child.queue_free()


func _update_spawn():
	_clear_childs()
	var spike = spike_scene.instance()
	add_child(spike)
	spike.position = Vector2()
	for i in range(width_left):
		spike = spike_scene.instance()
		add_child(spike)
		spike.position.x = (i + 1) * -32
		spike.position.y = 0
	for i in range(width_right):
		spike = spike_scene.instance()
		add_child(spike)
		spike.position.x = (i + 1) * 32
		spike.position.y = 0
