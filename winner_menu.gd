extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var mainmenu: Button = $MainmenuButton
@onready var wintitle = $WinTitle
@onready var scoreresult = $Scoreresulttext
@onready var vbox = $VBoxContainer

var defaulttext = " WIN"
var playerwintext
var scoreboard = []

func _ready() -> void:
	MusicSfx.gameover()
	initialize_scoreboard()
	scoreboard.sort_custom(sort_by_score)
	show_scoreboard()
	
	var text = str(playerwintext, defaulttext).to_upper()
	wintitle.text = (text)
	 
func _process(delta: float) -> void:
	button_hovered(mainmenu)
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_mainmenu_button_pressed() -> void:
	MusicSfx.button_click()
	Global.game_finished = false
	Global.player1_score = 0
	Global.player2_score = 0
	Global.player3_score = 0
	Global.player4_score = 0
	get_tree().change_scene_to_file("res://main_menu.tscn")

func sort_by_score(a, b):
	return a["score"] > b["score"]

func initialize_scoreboard():
	# Initialize the scoreboard with valid player names and scores
	if Global.player1_name != "":
		scoreboard.append({"name": Global.player1_name, "score": Global.player1_score})
	if Global.player2_name != "":
		scoreboard.append({"name": Global.player2_name, "score": Global.player2_score})
	if Global.player3_name != "":
		scoreboard.append({"name": Global.player3_name, "score": Global.player3_score})
	if Global.player4_name != "":
		scoreboard.append({"name": Global.player4_name, "score": Global.player4_score})

func show_scoreboard():
	for child in vbox.get_children():
		child.queue_free()
	
	var number: int = 0
	for i in scoreboard:
		number += 1
		var resulttext = scoreresult.duplicate()
		resulttext.text = str(number) + ". " + i.name + ": " + str(i.score)
		vbox.add_child(resulttext)
		
		if number == 1:
			playerwintext = i.name
