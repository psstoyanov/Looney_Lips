extends Node2D

var player_words = [] # The player words to use for the story
var prompt = ["thing", "thing", "feeling", "feeling", "action", "feeling"]

var story = "Once upon a time %s ate a %s and felt very %s. He was quite %s to %s very %s"

var intro = "Welcome to Looney Lips! \nWant to play a game? \n \n"

func _ready():
	displayIntro()
	check_player_words_lenght()
	$Blackboard/LineEdit.grab_focus()

func displayIntro():
	$Blackboard/StoryText.text = intro

func _on_TextureButton_pressed():
	processPlayerInput()

func _on_LineEdit_text_entered(new_text):
	processPlayerInput()


func check_player_words_lenght():
	if(player_words.size() < prompt.size()):
		$Blackboard/StoryText.text += ("Can I have a " + prompt[player_words.size()] + ", please?")
	else:
		tellStory()

func processPlayerInput():
	player_words.append($Blackboard/LineEdit.text)
	$Blackboard/LineEdit.text = ""
	$Blackboard/StoryText.text = ""
	check_player_words_lenght()

func tellStory():
	$Blackboard/StoryText.text = story % player_words
