extends Node2D

const head = preload ("res://enemyTest/Head.tscn")
const body = preload ("res://enemyTest/Body.tscn")
var bodyCount = 0

func _ready():
	spawnMob(5)

func spawnMob(quantity):
	var newHead = head.instance()
	newHead.name = "Head"
	newHead.follow = get_parent().get_parent().get_parent().get_node("PlayerManager/Active")
	newHead.connect("onHit",self,"takeDamage")
	add_child(newHead)
	for i in quantity:
		var newBody = body.instance()
		newBody.name = str("Body",bodyCount)
		newBody.connect("onHit",self,"takeDamage")
		if bodyCount == 0:
			newBody.get_node("Sprite").region_rect = Rect2(Vector2(32,0),Vector2(16,16))
			newBody.follow = get_node("Head")
		elif bodyCount == 1:
			newBody.get_node("Sprite").region_rect = Rect2(Vector2(16,0),Vector2(16,16))
			newBody.follow = get_node(str("Body",bodyCount-1))
		else:
			newBody.get_node("Sprite").region_rect = Rect2(Vector2(0,0),Vector2(16,16))
			newBody.follow = get_node(str("Body",bodyCount-1))
		print(newBody.name)
		bodyCount += 1
		add_child(newBody)

func takeDamage():
	var bodyCount = get_child_count()
	get_child(bodyCount-1).queue_free()
