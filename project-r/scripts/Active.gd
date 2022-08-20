extends KinematicBody2D

var speed = 300
var deltaT

func _physics_process(delta):
	deltaT = delta
	walking()

func walking():
	var direction = Vector2()
	if Input.is_action_pressed("move_right"):
		direction += Vector2(1,0)
	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1,0)
	if Input.is_action_pressed("move_up"):
		direction += Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		direction += Vector2(0,1)
	move_and_collide(direction.normalized() * speed * deltaT)
	
	
