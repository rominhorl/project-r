extends StaticBody2D

var sprites = [0,3]
var healthPoints = 2
var isExit = false
const holePath = "res://scenes/Hole.tscn"

func _ready():
	selectSprite()


func selectSprite():
	randomize()
	var spriteSelected = randi() % 2
	$Sprite.frame = sprites[spriteSelected]

func getMined():
	healthPoints -= 1
	$AnimationPlayer.play("hit")
	if healthPoints == 0:
		spawnHole()
		getDestroyed()
		
func getDestroyed():
	$AnimationPlayer.play("destroy")
	self.queue_free()

func spawnHole():
	if isExit:
		var holeResource = preload(holePath)
		var hole = holeResource.instance()
		hole.set_position(self.position + Vector2(8,8))
		get_parent().add_child(hole)
		

signal teste


