extends Area2D

var player

func _ready():
	var player = get_tree().get_nodes_in_group("Player")
	player[0].connect("toggle_on", self, "_on_toggle_on")
	player[0].connect("toggle_off", self, "_on_toggle_off")

func _on_Terminal_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().set_group("Player", "is_on_terminal", true)


func _on_Terminal_body_exited(body):
	if body.is_in_group("Player"):
		get_tree().set_group("Player", "is_on_terminal", false)

func _on_toggle_on():
	$AnimatedSprite.play("active")

func _on_toggle_off():
	$AnimatedSprite.play("default")
	pass
