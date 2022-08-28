extends Node

func _ready():
	$AnimationPlayer.play("fade in")

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
