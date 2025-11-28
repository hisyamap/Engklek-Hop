extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var restart: Button = $VBoxContainer/RestartButton
@onready var mainmenu: Button = $VBoxContainer/MainmenuButton
@onready var currentscore = $VBoxContainer/CurrentScore
@onready var highscore = $VBoxContainer/HighScore
@onready var reason_english = $VBoxContainer2/Reason_English
@onready var reason_indo = $VBoxContainer2/Reason_Indo

var highscoring

var currentscore_defaulttext = "SCORE: "
var highscore_defaulttext = "HIGHSCORE: "

var kalahgerak_text = "Kamu salah gerakan melompat"
var losemove_text = "You do the wrong jump move"
var kalahbatu_text = "Kamu lupa mengambil batu"
var loserock_text = "You forgot to pickup the rock"

func _process(delta: float) -> void:
	button_hovered(restart)
	button_hovered(mainmenu)
	
	match Global.category:
		1:
			highscoring = Global.present_highscore
		2:
			highscoring = Global.past_highscore
		3:
			highscoring = Global.continous_highscore
		4:
			highscoring = Global.perfect_highscore
	
	var highscore_text = str(highscore_defaulttext, str(highscoring))
	highscore.text = (highscore_text)
	var currentscore_text = str(currentscore_defaulttext, str(Global.currentscore))
	currentscore.text = (currentscore_text)
	
	if Global.lose_condition == 1:
		reason_english.text = losemove_text
		reason_indo.text = kalahgerak_text
	elif Global.lose_condition == 2:
		reason_english.text = loserock_text
		reason_indo.text = kalahbatu_text
	else:
		reason_english.text = ""
		reason_indo.text = ""
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_restart_button_pressed():
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://singleplayer.tscn")
	Global.currentscore = 0
	Global.lose_condition = 0

func _on_mainmenu_button_pressed():
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	Global.currentscore = 0
	Global.lose_condition = 0
