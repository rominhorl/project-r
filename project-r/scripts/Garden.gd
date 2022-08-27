extends Node2D

# Variables

var isPlayerOnWell = false
var isPlayerOnDoor = false

var houseScene = "res://scenes/maps/House.tscn"
var caveScene = "res://scenes/maps/Cave.tscn"

# Signals

signal changeScene(Scene)

# Processing

func _ready():
	connect("changeScene",get_parent(),'changeScene')
	
func _process(delta):
	goDownWell()
	goToHouse()

# Functions

func goDownWell():
	if isPlayerOnWell and Input.is_action_just_pressed("interact"):
		emit_signal("changeScene",caveScene)

func goToHouse():
	if isPlayerOnDoor and Input.is_action_just_pressed("interact"):
		emit_signal("changeScene",houseScene)


# Signals Functions

func _on_WellInteraction_body_entered(body):
	print('entrou no well')
	isPlayerOnWell = true

func _on_WellInteraction_body_exited(body):
	print('saiu no well')
	isPlayerOnWell = false

func _on_OutsideDoor_body_entered(body):
	print('entrou na porta')
	isPlayerOnDoor = true

func _on_OutsideDoor_body_exited(body):
	print('saiu da porta')
	isPlayerOnDoor = false
