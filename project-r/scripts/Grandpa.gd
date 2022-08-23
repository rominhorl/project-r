extends KinematicBody2D

var interactionPossible = false

signal callDialogGrandpa(dialog)

func _process(delta):
	if interactionPossible == true and Input.is_action_just_pressed("interact"):
		emit_signal("callDialogGrandpa", "1")


func _on_InteractionArea_body_entered(body):
	interactionPossible = true


func _on_InteractionArea_body_exited(body):
	interactionPossible = false
