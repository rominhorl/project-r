extends Node2D

var textSpeed = 0.005
var dialogDatabase = preload("res://DialogDatabase.gd")
var dialogProgress = 0
var isDialogFinished = false

func _ready():
	$Box/Text.visible_characters = 0
	
func _process(delta):
	dialogProcess("0")
	pass

func dialogProcess(dialog):
	var dialogLength = dialogDatabase.dialogDatabase.get(dialog).size()
	
	if dialogProgress == 0 and $Box/Text.visible_characters < len($Box/Text.text):
		$Box/Name.text = dialogDatabase.dialogDatabase.get(dialog).get("0").get("name")
		$Box/Text.text = dialogDatabase.dialogDatabase.get(dialog).get("0").get("text")
		$Box/Text.visible_characters += 1
		yield(get_tree().create_timer(textSpeed), "timeout")
	if Input.is_action_just_pressed("interact") and dialogProgress < dialogLength-1:
		dialogProgress += 1
		$Box/Text.visible_characters = 0
		$Box/Name.text = dialogDatabase.dialogDatabase.get(dialog).get(str(dialogProgress)).get("name")
		$Box/Text.text = dialogDatabase.dialogDatabase.get(dialog).get(str(dialogProgress)).get("text")
		while $Box/Text.visible_characters < len($Box/Text.text):
			$Box/Text.visible_characters += 1
			yield(get_tree().create_timer(textSpeed), "timeout")
	if Input.is_action_just_pressed("interact") and dialogProgress >= dialogLength-1:
		queue_free()



