extends Control

const dialogBox = preload("res://scenes/DialogBox.tscn")

func callDialog(dialogPicker):
	var newDialog = dialogBox.instance()
	newDialog.dialogPicker = dialogPicker
	add_child(newDialog)

