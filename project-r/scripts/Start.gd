extends Node

func _ready():
	$AnimationPlayer.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/Menu.tscn")
