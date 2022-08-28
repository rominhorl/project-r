extends KinematicBody2D

var interactionPossible = false

signal callDialogGrandpa(dialog)

func _process(delta):
	if Input.is_action_just_pressed("interact") and interactionPossible:
		var newDialogue = Dialogic.start('vocasa')
		add_child(newDialogue)


func _on_InteractionArea_body_entered(body):
	interactionPossible = true


func _on_InteractionArea_body_exited(body):
	interactionPossible = false
