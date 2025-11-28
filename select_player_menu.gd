extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var readybutton: Button = $ReadyButton
@onready var backbutton: Button = $BackButton
@onready var player1name = $Player1Name
@onready var player2name = $Player2Name
@onready var player3name = $Player3Name
@onready var player4name = $Player4Name

func _process(delta: float) -> void:
	button_hovered(readybutton)
	button_hovered(backbutton)
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2(0.9,0.9) * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2(0.9,0.9), tween_duration)

func _on_ready_button_pressed() -> void:
	MusicSfx.button_click()
	Global.player1_name = player1name.text
	Global.player2_name = player2name.text
	Global.player3_name = player3name.text
	Global.player4_name = player4name.text
	get_tree().change_scene_to_file("res://select_catergory_menu.tscn")

func _on_back_button_pressed() -> void:
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://main_menu.tscn")
