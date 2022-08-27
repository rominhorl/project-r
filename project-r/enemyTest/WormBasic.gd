extends Node2D

const head = preload ("res://enemyTest/Head.tscn")
const body = preload ("res://enemyTest/Body.tscn")
var bodyCount = 0

func _ready():
	spawnMob(8)

func spawnMob(quantity):
	var newHead = head.instance()
	newHead.name = "Head"
	newHead.follow = get_parent().get_parent().get_parent().get_node("PlayerManager/Active")
	add_child(newHead)
	for i in quantity:
		var newBody = body.instance()
		newBody.name = str("Body",bodyCount)
		if bodyCount == 0:
			newBody.follow = get_node("Head")
		else:
			newBody.follow = get_node(str("Body",bodyCount-1))
		print(newBody.name)
		bodyCount += 1
		add_child(newBody)
