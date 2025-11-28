extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var nextlevel: Button = $VBoxContainer/NextLevelButton
@onready var mainmenu: Button = $VBoxContainer/MainmenuButton

@onready var singleplayer_mode = get_node("/root/Singleplayer/")
@onready var multiplayer_mode = get_node("/root/Multiplayer/")
@onready var world

func _ready() -> void:
	if Global.singleplayer:
		world = singleplayer_mode
		mainmenu.show()
	else:
		world = multiplayer_mode
		mainmenu.hide()

func _process(delta: float) -> void:
	button_hovered(nextlevel)
	button_hovered(mainmenu)
	
	if Global.singleplayer:
		update_score()
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_next_level_button_pressed() -> void:
	MusicSfx.button_click()
	world.levelpassedMenu()
	if Global.singleplayer:
		get_tree().reload_current_scene()

func _on_mainmenu_button_pressed() -> void:
	MusicSfx.button_click()
	world.levelpassedMenu()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	Global.currentscore = 0

func update_score():
	Global.previousscore = Global.currentscore
	match Global.category:
		1:
			if Global.currentscore > Global.present_highscore:
				Global.present_highscore = Global.currentscore
		2:
			if Global.currentscore > Global.past_highscore:
				Global.past_highscore = Global.currentscore
		3:
			if Global.currentscore > Global.continous_highscore:
				Global.continous_highscore = Global.currentscore
		4:
			if Global.currentscore > Global.perfect_highscore:
				Global.perfect_highscore = Global.currentscore
	Global.save_score()
