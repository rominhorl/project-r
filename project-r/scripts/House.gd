extends Node2D

# Variables

var isPlayerOnDoor = false
var gardenScene = "res://scenes/maps/Garden.tscn"
var spawn

# Signal

signal changeScene(Scene)

# Processing

func _ready():
	connect("changeScene",get_parent(),'changeScene')
	$Grandpa.connect("callDialogGrandpa", $DialogManagerV2, "callDialog")
	$Marina.connect("callDialogMarina", $DialogManagerV2, "callDialog")
	#$DialogManagerV2.callDialog("0")

	
func _process(delta):
	goToGarden()


# Functions

func goToGarden():
	if isPlayerOnDoor and Input.is_action_just_pressed("interact"):
		emit_signal("changeScene",gardenScene)

# Signals Functions

func _on_InsideDoor_body_entered(body):
	print('entrei')
	isPlayerOnDoor = true


func _on_InsideDoor_body_exited(body):
	print('sai')
	isPlayerOnDoor = false
