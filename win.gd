extends Area2D



func _ready():
	pass 


func win():
	$Label.show()
	get_parent().get_node("music").stop()
	$win.play()
	var timer = Timer.new()
	timer.pause_mode = Node.PAUSE_MODE_PROCESS
	timer.wait_time = 1.5
	timer.autostart = true
	timer.connect("timeout", self, "go_back")
	add_child(timer)
	get_tree().paused = true

func go_back():
	scene_loader.goto_scene("res://main_menu/menu.tscn")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		win()
