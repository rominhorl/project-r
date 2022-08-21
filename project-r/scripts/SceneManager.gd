extends Node2D

# Processing

onready var currentLevel = get_child(0)

# Signal Functions

func changeScene(scene):
	var nextLevel
	nextLevel = load(scene).instance()
	add_child(nextLevel)
	currentLevel.queue_free()
	currentLevel = nextLevel
