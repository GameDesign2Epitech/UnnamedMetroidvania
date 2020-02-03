extends Area2D

signal player_entered
signal player_left

func _on_Terminal_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().set_group("Player", "is_on_terminal", true)


func _on_Terminal_body_exited(body):
	if body.is_in_group("Player"):
		get_tree().set_group("Player", "is_on_terminal", false)
