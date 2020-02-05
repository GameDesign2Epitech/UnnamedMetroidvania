extends AnimatedSprite



func _on_Player_toggle_on():
	$one_time.animation = "1"


func _on_Player_toggle_off():
	$one_time.animation = "2"
