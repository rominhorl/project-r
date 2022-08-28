extends Node2D

# biblioteca de animação
const AniManager = preload("res://scripts/AnimationManager.gd")
onready var AM = AniManager.new()
var isActive = false
var isMining

func _ready():
	$Attack/Hit/CollisionShape2D.disabled = true
	$DogPickAxe/CollisionShape2D.disabled = true

func _process(delta):
#	$DogPickAxe/CollisionShape2D.set_deferred("disabled",true)
	isActive = get_parent().name == "Active"
	if isActive:
		if Input.is_action_just_pressed("attack"):
			$Attack/AnimationPlayer.play("DogAttack")
			aiming()
	
	
	var direction = get_parent().direction
	var animation = AM.manageAnimations(direction,isActive)
	$DogSprites.play(animation)
	if ($DogSprites.animation.left(4) == "Mine") and $DogSprites.frame == 1:
		$DogPickAxe/CollisionShape2D.set_deferred("disabled",true)
	mineDirection()
	
func aiming():
	if get_global_mouse_position().x > global_position.x:
		$Attack.scale.x = 1
	if get_global_mouse_position().x < global_position.x:
		$Attack.scale.x = -1




func _on_Hit_body_entered(body):
	if body.is_in_group("enemy"):
		$Attack/Hit/CollisionShape2D.set_deferred("disabled",true)
		body.onHit()


func _on_DogSprites_animation_finished():
	if ($DogSprites.animation.left(4) == "Mine"):
		$DogPickAxe/CollisionShape2D.set_deferred("disabled",false)
		print($DogPickAxe/CollisionShape2D.disabled)

func mineDirection():
	if $DogSprites.animation == 'Mine_Left':
		$DogPickAxe.position = Vector2(-14,0)
	if $DogSprites.animation == 'Mine_Right':
		$DogPickAxe.position = Vector2(14,0)
	if $DogSprites.animation == 'Mine_Up':
		$DogPickAxe.position = Vector2(0,-14)
	if $DogSprites.animation == 'Mine_Down':
		$DogPickAxe.position = Vector2(0,14)

func _on_DogPickAxe_area_entered(area):
	if area.is_in_group('Rocks'):
		area.getMined()
		$DogPickAxe/CollisionShape2D.set_deferred("disabled",true)
