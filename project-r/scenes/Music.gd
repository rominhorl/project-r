extends Node2D


func _ready():
	pass 

func _process(delta):
	playMusic($AudioStreamPlayer)

func playMusic(musicNode):
	if musicNode.playing == false:
		musicNode.play()
