extends Node2D

func _ready():
	pass

func setSpawnPosition(pos):
	if (get_node("PlayerManager").get_child_count() == 2):
		$PlayerManager.position = Vector2(0,0)
		$PlayerManager/Active.position = pos
		$PlayerManager/Secondary.position = pos
	else:
		$PlayerManager.position = Vector2(0,0)
		$PlayerManager/Active.position = pos
