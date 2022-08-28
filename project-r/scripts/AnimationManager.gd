extends Node
var isIdle = true
var lastDirection = Vector2(0,0)
var directionState = 'Down'
var animationState = 'Idle'


func manageAnimations(direction, isActive):
	isIdle = (direction == Vector2(0,0))
	if (isIdle == false):
		lastDirection = direction

	setAnimationState(isIdle, isActive)
	setDirectionState(lastDirection)

	var animation = animationState + "_" + directionState
	return animation
	#print(direction)

# when i used it as fuction i got an error. Wont fix for game jam release
func setAnimationState(isIdle, isActive):
	var mineInput = Input.is_action_just_pressed("mine") or Input.is_action_pressed("mine")
	if isIdle:
		animationState = 'Idle'
	if mineInput and isActive:
		animationState = 'Mine'
	if not isIdle:
		animationState = 'Walk'

func setDirectionState(lastDirection):
	if lastDirection.y > 0.01:
		directionState = 'Down'
	elif lastDirection.y < -0.01:
		directionState = 'Up'
	elif lastDirection.x < 0.01:
		directionState = 'Left'
	elif lastDirection.x > -0.01:
		directionState = 'Right'
	else:
		directionState = 'Down'
