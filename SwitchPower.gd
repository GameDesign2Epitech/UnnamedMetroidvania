extends Area2D

signal give_power

func _on_SwitchPower_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("give_power")
		queue_free()