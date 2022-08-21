extends KinematicBody2D

var primary
var path = null
var navigation_path = null
var direction := Vector2.ZERO
var speed = 100
var deltaT

func _ready():
	primary = get_parent().get_node("Active")
	navigation_path = $Pathfinding

func _physics_process(delta):
	deltaT = delta
	if primary and navigation_path:
		generate_path()
		navigate()
	move()
	
func generate_path():
	if primary != null and navigation_path != null:
		path = navigation_path.get_simple_path(global_position, primary.global_position, false)
	
func navigate():
	if path.size() > 0:
		direction = global_position.direction_to(path[1]) * speed
	
func move():
	if (primary.global_position-global_position).abs().length_squared() > Vector2(16,16).length_squared():
		move_and_collide(direction * deltaT)
