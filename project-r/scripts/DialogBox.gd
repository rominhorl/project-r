extends ColorRect

const dialogDatabase = preload("res://scripts/DialogDatabase.gd")
var dialogPicker = null
var dialogProgress = 0
var isPhraseFinished = false

func _ready():
	loadDialog(dialogPicker)

func _process(delta):
	if isPhraseFinished == true and Input.is_action_just_pressed("interact"):
		loadDialog(dialogPicker)
	
	if $Text.percent_visible != 1 and $Text.percent_visible > 0.25 and Input.is_action_just_pressed("interact"):
		$Tween.stop_all()
		isPhraseFinished = true
		$FinishIndicator.visible = true
		$Text.percent_visible = 1
		
		

func loadDialog(dialogPicker):
	get_tree().paused = true
	$FinishIndicator.visible = false
	if dialogProgress < dialogDatabase.dialogDatabase.get(str(dialogPicker)).size():
		isPhraseFinished = false
		rect_global_position = Vector2(100,230)
		$Name.text = dialogDatabase.dialogDatabase.get(str(dialogPicker)).get(str(dialogProgress)).get("name")
		$Text.bbcode_text = dialogDatabase.dialogDatabase.get(str(dialogPicker)).get(str(dialogProgress)).get("text")
		$Sprite.texture = load(str("res://assets/",$Name.text,"_idle.png"))
		$Text.percent_visible = 0
		$Tween.interpolate_property(
			$Text, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		dialogProgress += 1
	else:
		get_tree().paused = false
		queue_free()
		
	
func _on_Tween_tween_completed(object, key):
	isPhraseFinished = true
	$FinishIndicator.visible = true

