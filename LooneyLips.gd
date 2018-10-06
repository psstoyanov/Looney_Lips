extends Node2D

func _ready():
	var promt = ["Pako", "pizza", "full","sleepy","jump","bloated"]
	var story = "Once upon a time %s ate a %s and felt very %s. He was quite %s to %s very %s"
	
	$Blackboard/StoryText.text = story % promt
	print(story % promt)


func _on_TextureButton_pressed():
	var new_text = $Blackboard/LineEdit.text
	$Blackboard/StoryText.text = new_text
	ClearPlayerInput()

func _on_LineEdit_text_entered(new_text):
	$Blackboard/StoryText.text = new_text	
	ClearPlayerInput()

func ClearPlayerInput():
	$Blackboard/LineEdit.text = ""

