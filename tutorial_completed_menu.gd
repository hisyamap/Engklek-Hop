extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var restart: Button = $VBoxContainer/RestartButton
@onready var mainmenu: Button = $VBoxContainer/MainmenuButton

func _ready() -> void:
	MusicSfx.level_passed()

func _process(delta: float) -> void:
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

func _on_restart_button_pressed():
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://tutorial.tscn")

func _on_mainmenu_button_pressed():
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://main_menu.tscn")
