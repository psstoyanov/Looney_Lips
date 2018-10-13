extends Node2D

var player_words = [] # The player words to use for the story

var current_story

var strings

func _ready():
	choose_random_story()
	get_other_strings()
	display_intro()

func get_other_strings():
	var other_strings = get_from_json("other_strings.json")
	strings = other_strings

func choose_random_story():
	randomize()
	var stories = get_from_json("stories.json")
	current_story = stories[randi() % stories.size()]

func get_from_json(filename):
	var filedir = "res://" + filename
	var file = File.new()
	file.open(filedir, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func display_intro():
	$Blackboard/StoryText.show()
	$Blackboard/StartGameButton.show()
	$Blackboard/StoryText.text = strings.intro
	$Blackboard/StartGameButton/RichTextLabel.text = strings.play_game
	$Blackboard/NewWordButton.hide()
	$Blackboard/LineEdit.hide()

func _on_StartGameButton_pressed():
	if(player_words.size() < current_story.prompt.size()):
		hide_intro_story_and_start_button()
		print(ask_for_new_word())
	else:
		restart_the_game()

func hide_intro_story_and_start_button():
	$Blackboard/StoryText.hide()
	$Blackboard/StartGameButton.hide()
	$Blackboard/LineEdit.show()
	$Blackboard/NewWordButton.show()
	$Blackboard/LineEdit.placeholder_text = ask_for_new_word()

func ask_for_new_word():
	return strings.new_word_prompt % current_story.prompt[player_words.size()]

func _on_NewWordButton_pressed():
	check_player_words_lenght()

func _on_LineEdit_text_entered(new_text):
	check_player_words_lenght()

func check_player_words_lenght():
	if(player_words.size() < current_story.prompt.size()):
		add_player_word_to_story()
	elif(check_if_game_has_finished()):
		tell_story()

func add_player_word_to_story():
	$Blackboard/LineEdit.placeholder_text = ask_for_new_word()
	player_words.append($Blackboard/LineEdit.text)
	$Blackboard/LineEdit.text = ""

func tell_story():
	$Blackboard/StoryText.show()
	$Blackboard/StoryText.text = current_story.story % player_words
	show_play_again()

func show_play_again():
	$Blackboard/StoryText.text += strings.play_again_txt
	$Blackboard/StartGameButton.show()
	$Blackboard/StartGameButton/RichTextLabel.text = strings.button_again
	$Blackboard/LineEdit.queue_free() # Remove the LineEdit
	$Blackboard/NewWordButton.queue_free() # Remove the NewWordButton

func check_if_game_has_finished():
	return $Blackboard/LineEdit # If the player input still exists, tell the story first

func restart_the_game():
	get_tree().reload_current_scene()



