extends KinematicBody2D

var bodyIndex

var nav_agent : NavigationAgent2D

export var nav_agent_radius : float = 5
export var nav_optimize_path : bool = false
export var nav_avoidance_enabled : bool = true
export var character_speed_multiplier : float = 50

var velocity : Vector2

# final navigation destination position/point
var nav_destination : Vector2 
# next navigation destination position/point
var next_nav_position : Vector2 

# The normal path to the destination
var character_nav_path : Array = []

# The actual path being calcuated during travel, used in the draw function
var character_real_nav_path : Array = []

# Follow pointer
var follow

# Position of the head
var previousPosition : Vector2

signal onHit

func _ready() -> void:
	# init velocity
	# Vector2.ZERO is enumeration for Vector2(0,0)
	velocity = Vector2.ZERO 
	
	nav_agent = $NavigationAgent2D
	# connect nav agent signal callback functions
	nav_agent.connect("path_changed", self, "character_path_changed")
	nav_agent.connect("target_reached", self, "character_target_reached_reached")
	nav_agent.connect("navigation_finished", self, "character_navigation_finished")
	nav_agent.connect("velocity_computed", self, "character_velocity_computed")
	# config nav agent attributes
	nav_agent.max_speed = character_speed_multiplier
#	nav_agent.radius = nav_agent_radius
	nav_agent.avoidance_enabled = nav_avoidance_enabled

func _physics_process(_delta : float) -> void:
	# get the next nav position from the character's navigation agent
	next_nav_position = nav_agent.get_next_location()
	# add the next nav position to the 'real' path for draw function
	character_real_nav_path.push_back(next_nav_position)
	# calculate the desired velocity, i.e velocity pre nav server calculated
	var desired_velocity = global_position.direction_to(next_nav_position) * character_speed_multiplier
	
	# feed the desired into the navigation agent 
	# set_velocity will trigger a callback from velocity_computed signal
	nav_agent.set_velocity(desired_velocity)
	
	previousPosition = follow.global_position
	
	set_navigation_position(previousPosition)
	
func set_navigation_position(nav_position_to_set : Vector2) -> void:
	nav_destination = nav_position_to_set
	
	# set the new character target location
	nav_agent.set_target_location(nav_destination)
	
	# calculate a new map path with the server using character nav agent map and new nav destination
	character_nav_path = Navigation2DServer.map_get_path(nav_agent.get_navigation_map(), global_position, nav_destination, nav_optimize_path)
	
	# clear the old real nav path, used for draw function
	character_real_nav_path.clear()
	
func character_path_changed() -> void:
	# TODO, implement this function to add behavior for character
	pass
	
func character_target_reached_reached() -> void:
	# TODO, implement this function to add behavior for character
	# currently using is_target_reached() in character_velocity_computed()
	pass
	
func character_navigation_finished() -> void:
	# TODO, implement this function to add behavior for character
	pass
	
func character_velocity_computed(calculated_velocity : Vector2) -> void:
	velocity = calculated_velocity
	
	# check if nav agent target is reached
	if (previousPosition-global_position).abs().length_squared() > Vector2(5,5).length_squared():
		# move and slide with the new calculated velocity
		velocity = move_and_slide(velocity)
	else:
		# if reached target, stand at the closest point in the navigation map
		global_position = Navigation2DServer.map_get_closest_point(nav_agent.get_navigation_map(), global_position)

func onHit():
	emit_signal("onHit")
	print("Headshot")
