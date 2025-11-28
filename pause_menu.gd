extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var resume: Button = $VBoxContainer/ResumeButton
@onready var restart: Button = $VBoxContainer/RestartButton
@onready var mainmenu: Button = $VBoxContainer/MainmenuButton

@onready var singleplayer_mode = get_node("/root/Singleplayer/")
@onready var multiplayer_mode = get_node("/root/Multiplayer/")
@onready var world

func _ready() -> void:
	if Global.singleplayer:
		world = singleplayer_mode
	else:
		world = multiplayer_mode

func _process(delta: float) -> void:
	button_hovered(resume)
	button_hovered(restart)
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

func _on_resume_button_pressed() -> void:
	MusicSfx.button_click()
	world.pauseMenu()

func _on_restart_button_pressed() -> void:
	MusicSfx.button_click()
	world.pauseMenu()
	get_tree().reload_current_scene()
	Global.currentscore = 0
	Global.lose_condition = 0

func _on_mainmenu_button_pressed() -> void:
	MusicSfx.button_click()
	world.pauseMenu()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	Global.currentscore = 0
	Global.lose_condition = 0
