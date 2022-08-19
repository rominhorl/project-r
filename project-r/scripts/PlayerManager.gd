extends Node2D

signal GameStarted

func _ready():
	connect("GameStarted",$Dog,"PlayerChoosen")
	connect("GameStarted",$Cat,"PlayerChoosen")
