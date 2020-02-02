extends KinematicBody2D

signal scene_change
signal toggle_on
signal toggle_off

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200
export (bool) var can_double_jump = true

var velocity = Vector2()
var jumping = false
var double_jumping = false
var is_on_terminal = false
var state = false
var cursor_mode = false

var scene_pos_x = 1
var scene_pos_y = 1

func _ready():
	$E.visible = false

func get_input():
	#Stocker les inputs
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('jump')
	var jump_cut = Input.is_action_just_released('jump')
	var space = Input.is_action_just_pressed('ui_select')
	
	if space and state:
		if cursor_mode:
			cursor_mode = false
			$Cursor.enabled = false
		else:
			cursor_mode = true
			$Cursor.enabled = true
	
	#Animation au sol
	if is_on_floor():
		$AnimatedSprite.animation = "idle"
	
	if !cursor_mode:
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
		#Fait un saut court si le bouton de saut n'est pas maintenu
		if jump_cut and !is_on_floor():
			if velocity.y < -200:
				velocity.y = -200
		#Calcul de la vélocité et changement de sprite en fonction de la direction
		if right:
			velocity.x += run_speed
			$AnimatedSprite.flip_h = false
		if left:
			velocity.x -= run_speed
			$AnimatedSprite.flip_h = true
		if Input.is_action_just_released("use") and is_on_terminal:
			if state:
				can_double_jump = true
				state = false
				emit_signal("toggle_off")
			else:
				can_double_jump = false
				state = true
				emit_signal("toggle_on")
	
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

func _process(delta):
	#Si on sort de l'écran, envoyer un signal à la caméra pour qu'elle bouge
	if position.x > 960 * scene_pos_x:
		scene_pos_x += 1
		scene_change(1, 0)
	if position.x < 960 * (scene_pos_x - 1):
		scene_pos_x -= 1
		scene_change(-1, 0)
	if position.y > 544 * scene_pos_y:
		scene_pos_y += 1
		scene_change(0, 1)
	if position.y < 544 * (scene_pos_y -1):
		scene_pos_y -= 1
		scene_change(0, -1)

#Restaurer le double saut et désactiver tout les mécanismes lors d'un changement de salle
func scene_change(x, y):
	can_double_jump = true
	state = false
	emit_signal("toggle_off")
	get_tree().call_group("activeable", "set_state", false)
	emit_signal("scene_change", x, y)

func _on_Terminal_player_entered():
	is_on_terminal = true
	$E.visible = true

func _on_Terminal_player_left():
	is_on_terminal = false
	$E.visible = false
