extends Node2D

func _ready():
	$Attack/Hit/CollisionShape2D.disabled = true

func _process(delta):
	if get_parent().name == "Active":
		if Input.is_action_just_pressed("attack"):
			$Attack/AnimationPlayer.play("DogAttack")
			aiming()
		
func aiming():
	if get_global_mouse_position().x > global_position.x:
		$Attack.scale.x = 1
	if get_global_mouse_position().x < global_position.x:
		$Attack.scale.x = -1




func _on_Hit_body_entered(body):
	if body.is_in_group("enemy"):
		$Attack/Hit/CollisionShape2D.set_deferred("disabled",true)
		body.onHit()
