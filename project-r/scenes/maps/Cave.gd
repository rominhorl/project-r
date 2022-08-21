extends Node2D

var isMouseOverHole = false



func _on_Area2D_mouse_entered():
	isMouseOverHole = true


func _on_Area2D_mouse_exited():
	isMouseOverHole = false
