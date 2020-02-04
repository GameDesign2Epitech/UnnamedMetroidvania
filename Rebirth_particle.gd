extends AnimatedSprite

var grow_speed = 40
var vanish_speed = 2
var alpha = 1

func _process(delta):
	scale.x += grow_speed * delta
	scale.y += grow_speed * delta
	alpha -= vanish_speed * delta
	modulate = Color(1, 1, 1, alpha)
	if alpha <= 0:
		queue_free()