extends StaticBody2D


var sprites = [1,4]

func _ready():
	selectSprite()

func selectSprite():
	randomize()
	var spriteSelected = randi() % 2
	$Sprite.frame = sprites[spriteSelected]
