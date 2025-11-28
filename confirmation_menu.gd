extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var yes: Button = $HBoxContainer/YesButton
@onready var no: Button = $HBoxContainer/NoButton
@onready var world = get_node("/root/Multiplayer/")

func _process(delta: float) -> void:
	button_hovered(yes)
	button_hovered(no)
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_yes_button_pressed() -> void:
	MusicSfx.button_click()
	reset_multiplayer()
	world.confirmationMenu()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_no_button_pressed() -> void:
	MusicSfx.button_click()
	world.confirmationMenu()
	self.hide()
	
func reset_multiplayer():
	Global.player1_turn = false
	Global.player2_turn = false
	Global.player3_turn = false
	Global.player4_turn = false
	Global.player1_score = 0
	Global.player2_score = 0
	Global.player3_score = 0
	Global.player4_score = 0
	Global.game_finished = false
	Global.lose_condition = 0
