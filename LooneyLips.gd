extends Node2D

func _ready():
	var promt = ["Pako", "pizza", "full"]
	var story = "Once upon a time %s ate a %s and felt very %s"
	
	print(story % promt)