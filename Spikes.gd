extends Area2D

#export (int) var width_left = 0
#export (int) var width_right = 0

func _ready():
#	var spike
#	for i in range(width_left):
#		spike = spike_scene.instance()
#		spike.position.x = position.x + (i + 1) * 32
#		spike.position.y = position.y
#	for i in range(width_right):
#		spike = spike_scene.instance()
#		spike.position.x = position.x - (i + 1) * 32
#		spike.position.y = position.y
	pass

func _on_Spikes_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().call_group("Player", "player_die")
