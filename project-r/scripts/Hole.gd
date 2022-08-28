extends Node2D
var isOnHole = false

func _process(delta):
	if Input.is_action_just_pressed("interact") and isOnHole:
		print('a')
		get_tree().call_group("Rocks", "getDestroyed")
		get_tree().call_group("SceneManager", "changeCave")

func _on_Area2D_body_entered(body):
	print('a')
	isOnHole = true




func _on_Area2D_body_exited(body):
	isOnHole = false
