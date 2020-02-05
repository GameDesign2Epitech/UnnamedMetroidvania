extends Area2D

func _ready():
	if not Engine.editor_hint:
		connect("body_entered", self, "_on_Spikes_body_entered")
	pass

func _on_Spikes_body_entered(body):
		if body.is_in_group("Player"):
			get_tree().call_group("Player", "player_die")
