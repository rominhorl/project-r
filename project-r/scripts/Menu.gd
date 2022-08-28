extends Control

func _ready():
	$Cover/AnimationPlayer.play("Fade_In")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("attack"):
		$Tutorial.visible = false

func _on_HowToPlay_pressed():
	print('a')
	$Tutorial.visible = true


func _on_AnimationPlayer_animation_finished(anim_name):
	$Cover.queue_free()


func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
