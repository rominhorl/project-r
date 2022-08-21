extends Node2D

const characters = ["Cat", "Dog"]
var primary = null
var secondary = null

func _ready():
	pickCharacters()
	
func _process(delta):
	changeCharacter()

func pickCharacters():
	randomize()
	var characterSelection = randi() % 2
	primary  = get_node(str(characters[characterSelection]))
	remove_child(primary)
	$Active.add_child(primary)
	
	match characterSelection:
		0:
			secondary = get_node(str(characters[1]))
			continue
		1:
			secondary = get_node(str(characters[0]))
			continue
	remove_child(secondary)
	$Secondary.add_child(secondary)

func changeCharacter():
	if Input.is_action_just_pressed("switch_characters"):
		primary = $Active.get_child(1)
		secondary = $Secondary.get_child(1)
		$Active.remove_child(primary)
		$Secondary.add_child(primary)
		$Secondary.remove_child(secondary)
		$Active.add_child(secondary)
