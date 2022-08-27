extends Node2D

const projectile = preload("res://scenes/CatProjectile.tscn")
var projectileSpeed = 400

func _process(delta):
	if get_parent().name == "Active":
		if Input.is_action_just_pressed("attack"):
			var newProjectile = projectile.instance()
			randomize()
			var isBaseball = randi() % 10
			if isBaseball == 1:
				newProjectile.get_node("Sprite").frame = 1
			newProjectile.position = position
			newProjectile.rotation = get_angle_to(get_global_mouse_position())
			newProjectile.apply_impulse(Vector2(),Vector2(projectileSpeed,0).rotated(newProjectile.rotation))
			$Attack.add_child(newProjectile)
