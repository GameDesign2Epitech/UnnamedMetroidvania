extends Area2D

export (int) var speed = 100
var enabled = false
var velocity = Vector2()
var selection = null

func _ready():
	visible = false
	$E.visible = false

func _process(delta):
	visible = enabled
	if enabled:
		velocity.x = 0
		velocity.y = 0
		var right = Input.is_action_pressed('ui_right')
		var left = Input.is_action_pressed('ui_left')
		var up = Input.is_action_pressed("ui_up")
		var down = Input.is_action_pressed("ui_down")
		var use = Input.is_action_just_pressed("use")
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
		if use and selection != null:
			selection.toggle_state()
	else:
		position.x = 0
		position.y = 0


func _on_Cursor_body_entered(body):
	if enabled and body.has_method("toggle_state"):
		selection = body
		$E.visible = true


func _on_Cursor_body_exited(body):
	selection = null
	$E.visible = false
