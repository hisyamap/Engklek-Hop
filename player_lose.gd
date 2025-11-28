extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var nextplayer: Button = $VBoxContainer/NextplayerButton
@onready var result: Button = $VBoxContainer/ResultButton
@onready var playerscore = $VBoxContainer/CurrentScore
@onready var reason_english = $VBoxContainer2/Reason_English
@onready var reason_indo = $VBoxContainer2/Reason_Indo

@onready var world = get_node("/root/Multiplayer/")

var defaulttext = "SCORE: "

var kalahgerak_text = "Kamu salah gerakan melompat"
var losemove_text = "You do the wrong jump move"
var kalahbatu_text = "Kamu lupa mengambil batu"
var loserock_text = "You forgot to pickup the rock"

func _process(delta: float) -> void:
	button_hovered(nextplayer)
	button_hovered(result)
	
	if Global.game_finished == true:
		nextplayer.hide()
		result.show()
	else:
		nextplayer.show()
		result.hide()
		
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

func _on_nextplayer_button_pressed() -> void:
	MusicSfx.button_click()
	Global.lose_condition = 0
	world.playerloseMenu()

func _on_result_button_pressed() -> void:
	MusicSfx.button_click()
	Global.lose_condition = 0
	world.playerloseMenu()
	get_tree().change_scene_to_file("res://winner_menu.tscn")
	
func update_score():
	if Global.player1_turn:
		var text = str(defaulttext, str(Global.player1_score))
		playerscore.text = (text)
	elif Global.player2_turn:
		var text = str(defaulttext, str(Global.player2_score))
		playerscore.text = (text)
	elif Global.player3_turn:
		var text = str(defaulttext, str(Global.player3_score))
		playerscore.text = (text)
	elif Global.player4_turn:
		var text = str(defaulttext, str(Global.player4_score))
		playerscore.text = (text)
