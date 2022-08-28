extends KinematicBody2D

var speed = 100
var deltaT
var direction

func _physics_process(delta):
	deltaT = delta
	direction = setDirection()
	moveActivePlayer(direction)
	
	
func setDirection():
	var direction = Vector2()
	if Input.is_action_pressed("move_right"):
		direction += Vector2(1,0)
	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1,0)
	if Input.is_action_pressed("move_up"):
		direction += Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		direction += Vector2(0,1)
	return direction

func moveActivePlayer(direction):
	var velocity = direction.normalized() * speed
	move_and_slide(velocity)

func playerDeath():
	get_parent().playerDeath()



