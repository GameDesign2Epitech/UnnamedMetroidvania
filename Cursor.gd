extends Area2D

export (int) var speed = 100
var enabled = false
var velocity = Vector2()

func _ready():
	visible = false

func _process(delta):
	visible = enabled
	if enabled:
		velocity.x = 0
		velocity.y = 0
		var right = Input.is_action_pressed('ui_right')
		var left = Input.is_action_pressed('ui_left')
		var up = Input.is_action_pressed("ui_up")
		var down = Input.is_action_pressed("ui_down")
		if right:
			velocity.x += 1
		if left:
			velocity.x -= 1
		if up:
			velocity.y -= 1
		if down:
			velocity.y += 1
		velocity = velocity.normalized() * speed
		position += velocity * delta
	else:
		position.x = 0
		position.y = 0
