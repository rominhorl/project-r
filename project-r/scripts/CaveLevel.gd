extends Node2D

var spawn
const holePath = "res://scenes/Hole.tscn"

func _ready():
	spawn = $Spawn.position
	setExits()

func setExits():
	var childList = $Rocks.get_children()
	var numberOfExits = 5 - get_parent().caveLevel + 20
	for i in numberOfExits:
		var index = randi() % childList.size()
		childList[index].isExit = true
		childList.erase(index)
		
	
