extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200
export (bool) var can_double_jump = true

var velocity = Vector2()
var jumping = false
var double_jumping = false

func get_input():
	#Stocker les inputs
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')
	#Animation au sol
	if is_on_floor():
		$AnimatedSprite.animation = "idle"
	#Condition de saut
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
		$AnimatedSprite.animation = "jump"
	#Condition de double-saut
	if jump and !double_jumping and can_double_jump and !is_on_floor():
		double_jumping = true
		velocity.y = jump_speed
		$AnimatedSprite.animation = "jump"
	#Calcul de la vélocité et changement de sprite en fonction de la direction
	if right:
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true
	
func _physics_process(delta):
	get_input()
	#Calcul de la vélocité en fonction de la gravité
	if velocity.y < gravity:
		velocity.y += gravity * delta
	#Réinitialisation des variables de saut lorsqu'on touche le sol
	if jumping and is_on_floor():
		jumping = false
		double_jumping = false
	if double_jumping and is_on_floor():
		jumping = false
		double_jumping = false
	#Mouvement du personnage
	velocity = move_and_slide(velocity, Vector2(0, -1))