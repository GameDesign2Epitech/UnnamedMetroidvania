extends Camera2D

export (int) var speed = 10
var direction = Vector2()
var goal = Vector2()
var is_moving = false

func _on_Player_scene_change(x, y):
	direction.x = x
	direction.y = y
	goal.x = position.x + (direction.x * 960)
	goal.y = position.y + (direction.y * 544)
	print("goal_x: " + str(goal.x) + "; goal_y: " + str(goal.y))
	direction = direction.normalized()
	is_moving = true

func _process(delta):
	if is_moving:
		#get_tree().paused = true
		position += direction * delta * speed
		if position == goal:
			is_moving = false
		#get_tree().paused = false