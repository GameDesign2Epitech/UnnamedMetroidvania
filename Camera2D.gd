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
	#print("goal_x: " + str(goal.x) + "; goal_y: " + str(goal.y))
	direction = goal - position
	direction = direction.normalized() * speed
	is_moving = true
	get_tree().paused = true

func _move_towards_goal(delta):
	if position.distance_to(goal) < 10:
		position = goal
		is_moving = false
		get_tree().paused = false
	else:
		position += direction * delta
	#Je ne sais pas ce que c'est mais c'est important
	align()

func _process(delta):
	if is_moving:
		_move_towards_goal(delta)