extends Node2D

var player_words = [] # The player words to use for the story

var current_story

var strings

func _ready():
	choose_random_story()
	get_other_strings()
	display_intro()
	$Blackboard/LineEdit.grab_focus()

func get_other_strings():
	var other_strings = get_from_json("other_strings.json")
	strings = other_strings

func choose_random_story():
	randomize()
	var stories = get_from_json("stories.json")
	current_story = stories[randi() % stories.size()]

func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func display_intro():
	$Blackboard/StoryText.text = strings.intro + ask_for_new_word()

func ask_for_new_word():
	return strings.new_word_prompt % current_story.prompt[player_words.size()]

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
	$Blackboard/StoryText.text = ask_for_new_word()
	player_words.append($Blackboard/LineEdit.text)
	$Blackboard/LineEdit.text = ""

func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	show_play_again()

func show_play_again():
	$Blackboard/StoryText.text += strings.play_again_txt
	$Blackboard/TextureButton/RichTextLabel.text = strings.button_again
	$Blackboard/LineEdit.queue_free() # Remove the LineEdit

func check_if_game_has_finished():
	return $Blackboard/LineEdit # If the player input still exists, tell the story first

func restart_the_game():
	get_tree().reload_current_scene()