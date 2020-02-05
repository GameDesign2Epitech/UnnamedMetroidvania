extends Area2D

signal give_power
export var wave_strength = 4
export var speed = 4
var idx = 0
var original_y

func _ready():
	original_y = position.y

#Bouger la disquette pour donner l'impression qu'elle flotte dans les airs
func _process(delta):
	position.y = original_y + cos(idx) * wave_strength
	idx += delta * speed
	idx = fmod(idx, PI * 2)
	
func _on_SwitchPower_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("give_power")
		queue_free()
