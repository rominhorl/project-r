extends Node2D

signal playerToSceneSpawn(position)
var caveLevel = 0
var levelList

# Processing

onready var currentLevel = get_child(0)

func _ready():
	connect("playerToSceneSpawn",get_parent(),'setSpawnPosition')
	setCaveSystem()

# Signal Functions

func changeScene(scene):
	var nextLevel
	nextLevel = load(scene).instance()
	add_child(nextLevel)
	currentLevel.queue_free()
	currentLevel = nextLevel
	print(nextLevel.spawn)
	emit_signal("playerToSceneSpawn", nextLevel.spawn)
	
func setCaveSystem():
	randomize()
	var teste = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15"]
	levelList = []
	for i in 5:
		var item = randi() % teste.size()
		levelList.append(teste[item])
		teste.erase(item)
	levelList.append('EndScene')
	print(levelList)


func changeCave():
	print('caveLevel:' + str(caveLevel) + '/n' + 'mapa:' + str(levelList[caveLevel]))
	if levelList[caveLevel] != 'EndScene':
		var nextLevel = "res://scenes/maps/caves/" + levelList[caveLevel] + ".tscn"
		changeScene(nextLevel)
	if levelList[caveLevel] == 'EndScene':
		get_tree().change_scene("res://scenes/Ending.tscn")
	caveLevel += 1
