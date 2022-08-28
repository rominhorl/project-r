extends Node2D

const projectile = preload("res://scenes/CatProjectile.tscn")
var projectileSpeed = 400
var isActive = false

# biblioteca de animação
const AniManager = preload("res://scripts/AnimationManager.gd")
onready var AM = AniManager.new()

func _ready():
		$CatPickAxe/CollisionShape2D.disabled = true

func _process(delta):
	isActive = get_parent().name == "Active"
	if isActive:
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
			
	var direction = get_parent().direction
	var animation = AM.manageAnimations(direction, isActive)
	$CatSprites.play(animation)
	mineDirection()
	
	if ($CatSprites.animation.left(4) == "Mine") and $CatSprites.frame == 1:
		$CatPickAxe/CollisionShape2D.set_deferred("disabled",true)

func mineDirection():
	if $CatSprites.animation == 'Mine_Left':
		$CatPickAxe.position = Vector2(-14,0-14)
	if $CatSprites.animation == 'Mine_Right':
		$CatPickAxe.position = Vector2(14,0-14)
	if $CatSprites.animation == 'Mine_Up':
		$CatPickAxe.position = Vector2(0,-14-14)
	if $CatSprites.animation == 'Mine_Down':
		$CatPickAxe.position = Vector2(0,14-14)

func _on_CatPickAxe_area_entered(area):
	if area.is_in_group('Rocks'):
		area.getMined()
		$CatPickAxe/CollisionShape2D.set_deferred("disabled",true)


func _on_CatSprites_animation_finished():
	if ($CatSprites.animation.left(4) == "Mine"):
		$AudioStreamPlayer2D.play()
		$CatPickAxe/CollisionShape2D.set_deferred("disabled",false)
		print($CatPickAxe/CollisionShape2D.disabled)
