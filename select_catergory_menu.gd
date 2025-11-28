extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var presenttense: Button = $VBoxContainer/HBoxContainer/PresentTenseButton
@onready var pasttense: Button = $VBoxContainer/HBoxContainer/PastTenseButton
@onready var continoustense: Button = $VBoxContainer/HBoxContainer2/ContinousTenseButton
@onready var perfecttense: Button = $VBoxContainer/HBoxContainer2/PerfectTenseButton

func _process(delta: float) -> void:
	button_hovered(presenttense)
	button_hovered(pasttense)
	button_hovered(continoustense)
	button_hovered(perfecttense)
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_present_tense_button_pressed() -> void:
	MusicSfx.button_click()
	Global.category = 1
	if Global.singleplayer:
		get_tree().change_scene_to_file("res://singleplayer.tscn")
	else:
		get_tree().change_scene_to_file("res://multiplayer.tscn")

func _on_past_tense_button_pressed() -> void:
	MusicSfx.button_click()
	Global.category = 2
	if Global.singleplayer:
		get_tree().change_scene_to_file("res://singleplayer.tscn")
	else:
		get_tree().change_scene_to_file("res://multiplayer.tscn")

func _on_continous_tense_button_pressed() -> void:
	MusicSfx.button_click()
	Global.category = 3
	if Global.singleplayer:
		get_tree().change_scene_to_file("res://singleplayer.tscn")
	else:
		get_tree().change_scene_to_file("res://multiplayer.tscn")

func _on_perfect_tense_button_pressed() -> void:
	MusicSfx.button_click()
	Global.category = 4
	if Global.singleplayer:
		get_tree().change_scene_to_file("res://singleplayer.tscn")
	else:
		get_tree().change_scene_to_file("res://multiplayer.tscn")
