extends KinematicBody2D

var interactionPossible = false

signal callDialogMarina(dialog)

func _process(delta):
	if Input.is_action_just_pressed("interact") and interactionPossible:
		var newDialogue
		if get_parent().name == 'House':
			newDialogue = Dialogic.start('meninacasa')
		if get_parent().name == 'Garden':
			newDialogue = Dialogic.start('meninajardim')
		add_child(newDialogue)

func _on_InteractionArea_body_entered(body):
	interactionPossible = true
	print('entrou')


func _on_InteractionArea_body_exited(body):
	interactionPossible = false
	print('saiu')
