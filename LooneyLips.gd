extends Node2D

var player_words = [] # The player words to use for the story
var prompt = ["thing", "thing", "feeling", "feeling", "action", "feeling"]

var story = "Once upon a time %s ate a %s and felt very %s. He was quite %s to %s very %s"

var template = [{
		"prompt" : ["thing", "adjective", "feeling", "feeling", "action", "feeling"],
		"story" : "Once upon a time %s ate a %s and felt very %s. He was quite %s to %s very %s"
		},{
		"prompt" : ["noun", "adjective", "verb"],
		"story" : "Once upon a time %s bough %s and hastily %s."
		}]

var current_story

var intro = "Welcome to Looney Lips! \nWant to play a game? \n \n"
var new_word_promt = "Can I have a %s, please?"
var play_again_txt = "\n\n\n\nDo you want to play again?"
var button_again = "Again!"

func _ready():
	prepare_game()

func prepare_game():
	choose_random_story()
	display_intro()
	$Blackboard/LineEdit.grab_focus()

func choose_random_story():
	randomize()
	current_story = template[randi() % template.size()]

func display_intro():
	$Blackboard/StoryText.text = intro + (new_word_promt % current_story.prompt[player_words.size()])

func _on_TextureButton_pressed():
	check_player_words_lenght()

func _on_LineEdit_text_entered(new_text):
	check_player_words_lenght()

func check_player_words_lenght():
	if(player_words.size() < current_story.prompt.size()):
		add_player_word_to_story()
	elif(check_if_game_has_finished()):
		tell_story()
	else:
		restart_the_game()

func add_player_word_to_story():
	$Blackboard/StoryText.text = (new_word_promt % current_story.prompt[player_words.size()])
	player_words.append($Blackboard/LineEdit.text)
	$Blackboard/LineEdit.text = ""

func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	show_play_again()

func show_play_again():
	$Blackboard/StoryText.text += play_again_txt
	$Blackboard/TextureButton/RichTextLabel.text = button_again
	$Blackboard/LineEdit.queue_free() # Remove the LineEdit

func check_if_game_has_finished():
	return $Blackboard/LineEdit # If the player input still exists, tell the story first

func restart_the_game():
	get_tree().reload_current_scene()