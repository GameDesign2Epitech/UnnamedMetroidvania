extends KinematicBody2D

export (bool) var enabled = false
export (NodePath) var target
export (int) var speed = 100
export (int) var accuracy = 10
var goal = Vector2()
var next_goal = Vector2()
var direction = Vector2()

func _ready():
	goal = get_node(target).position
	next_goal = position
	direction = (goal - position).normalized()

func _move_towards_goal(delta):
	#Si la plateforme est à moins de 10 pixels de là où elle doit être
	#alors on la téléporte directement dessus et on change le goal
	if position.distance_to(goal) < accuracy:
		position = goal
		goal = next_goal
		next_goal = position
		direction = (goal - position).normalized()
	#Sinon on bouge la plateforme en direction de goal
	else:
		position += direction * delta * speed

func _process(delta):
	if enabled:
		$AnimatedSprite.animation = "enabled"
		_move_towards_goal(delta)
	else:
		$AnimatedSprite.animation = "disabled"

func toggle_state():
	if enabled:
		enabled = false
	else:
		enabled = true

func set_state(new_state):
	enabled = new_state