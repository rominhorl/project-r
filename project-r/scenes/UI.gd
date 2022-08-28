extends Control

func _process(delta):
	playMusic()

func playMusic():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
