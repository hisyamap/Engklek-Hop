extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var singleplayer: Button = $VBoxContainer/SingleplayerButton
@onready var twoplayer: Button = $VBoxContainer/MultiplayerButton
@onready var settings: Button = $VBoxContainer/SettingsButton
@onready var tutorial: Button = $VBoxContainer/TutorialButton
@onready var funfact: Button = $FunfactButton
@onready var maximize: Button = $MaximizeButton
@onready var minimize: Button = $MinimizeButton

func _ready() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(MusicSfx.config.get_value("Audio", '1')))
	AudioServer.set_bus_volume_db(2, linear_to_db(MusicSfx.config.get_value("Audio", '2')))
	MusicSfx.play_maintheme_music()
	
#	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
#		maximize.show()
#		minimize.hide()
#	else:
#		minimize.show()
#		maximize.hide()
	
func _process(delta: float) -> void:
	button_hovered(singleplayer)
	button_hovered(twoplayer)
	button_hovered(settings)
	button_hovered(tutorial)
	button_hovered(funfact)
	button_hovered(maximize)
	button_hovered(minimize)
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_singleplayer_button_pressed() -> void:
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://select_catergory_menu.tscn")
	Global.singleplayer = true

func _on_multiplayer_button_pressed() -> void:
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://select_player_menu.tscn")
	Global.singleplayer = false

func _on_settings_button_pressed() -> void:
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://settings_menu.tscn")

func _on_tutorial_button_pressed() -> void:
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://tutorial.tscn")

func _on_funfact_button_pressed() -> void:
	MusicSfx.button_click()
	Dialogic.start("funfact")

func _on_minimize_button_pressed() -> void:
	MusicSfx.button_click()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	minimize.hide()
	maximize.show()
	
func _on_maximize_button_pressed() -> void:
	MusicSfx.button_click()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	maximize.hide()
	minimize.show()
