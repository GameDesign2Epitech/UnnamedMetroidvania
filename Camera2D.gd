extends Camera2D

export (int) var speed = 10
var direction = Vector2()
var goal = Vector2()
var is_moving = false

func _ready():
	$overlay.visible = false
	$powerup.connect("finished", self, "_powerup_finished")

func _on_Player_scene_change(x, y):
	#Calcul de la futur position de la caméra
	direction.x = x
	direction.y = y
	goal.x = position.x + (direction.x * 960)
	goal.y = position.y + (direction.y * 544)
	#Déterminer la direction où la caméra doit aller
	direction = goal - position
	direction = direction.normalized() * speed
	is_moving = true
	#Stopper le reste du jeu
	get_tree().paused = true

func _move_towards_goal(delta):
	#Si la caméra est à moins de 10 pixels de là où elle doit être
	#alors on la téléporte directement dessus
	if position.distance_to(goal) < 10:
		position = goal
		is_moving = false
		get_tree().paused = false
	#Sinon on bouge la caméra en direction de goal
	else:
		position += direction * delta
	#Je ne sais pas ce que c'est mais c'est important
	align()

func _process(delta):
	if is_moving:
		_move_towards_goal(delta)

func _on_Player_toggle_on():
	$overlay.animation = "on"


func _on_Player_toggle_off():
	$overlay.animation = "off"


func _on_SwitchPower_give_power():
	$overlay.visible = true
	get_tree().paused = true
	$cl/popup/npr/mc/label.text = "Activating platforms power acquired"
	$cl/popup.popup_centered()
	$powerup.play()

func _on_GravityPower_acquired():
	get_tree().paused = true
	$cl/popup/npr/mc/label.text = "Gravity control   power acquired"
	$cl/popup.popup_centered()
	$powerup.play()


func _powerup_finished():
	#$pholder/popup.hide()
	get_tree().paused = false
	$cl/popup.hide()
	pass
