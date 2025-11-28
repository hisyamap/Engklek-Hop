extends CanvasLayer

@onready var gaco = get_node("%Gaco")
@onready var player = get_node("%Player")
@onready var PowerBar = $Control/PowerBar
@onready var score = $Control/Score
@onready var playerturn = $Control/PlayerTurn
@onready var singleplayer_mode = get_node("/root/Singleplayer/")
@onready var multiplayer_mode = get_node("/root/Multiplayer/")
var selectplayer_scene: PackedScene = load("res://select_player_menu.tscn")

@onready var maximize : Button = $CanvasLayer/HBoxContainer/MaximizeButton
@onready var minimize : Button = $CanvasLayer/HBoxContainer/MinimizeButton
@onready var pause : Button = $CanvasLayer/HBoxContainer/PauseButton
@export var tween_intensity: float
@export var tween_duration: float

var power = 100
var powerbar_speed = 0.1
var defaulttext = "Score: "
var turntext = "'s Turn"

func _ready() -> void:
	print("show ui")
#	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
#		maximize.show()
#		minimize.hide()
#	else:
#		minimize.show()
#		maximize.hide()

func _physics_process(delta: float) -> void:
	set_powerbar_speed()
	button_hovered(maximize)
	button_hovered(minimize)
	button_hovered(pause)
	
	if !gaco.powerbar:
		await get_tree().create_timer(1).timeout
		PowerBar.visible = false
	else:
		PowerBar.visible = true
		
	if Global.singleplayer:	
		var text = str(defaulttext, str(Global.previousscore))
		score.text = (text)
	else:
		player_turn_manager()
		if Global.player1_turn:
			var text = str(defaulttext, str(Global.player1_score))
			score.text = (text)
			playerturn.text = str(Global.player1_name, turntext)
		elif Global.player2_turn:
			var text = str(defaulttext, str(Global.player2_score))
			score.text = (text)
			playerturn.text = str(Global.player2_name, turntext)
		elif Global.player3_turn:
			var text = str(defaulttext, str(Global.player3_score))
			score.text = (text)
			playerturn.text = str(Global.player3_name, turntext)
		elif Global.player4_turn:
			var text = str(defaulttext, str(Global.player4_score))
			score.text = (text)
			playerturn.text = str(Global.player4_name, turntext)
	
func set_powerbar_speed():
	if score.text == "Score: 0":
		powerbar_speed = 0.1
	elif score.text == "Score: 100":
		powerbar_speed = 0.15
	elif score.text == "Score: 200":
		powerbar_speed = 0.2
	elif score.text == "Score: 300":
		powerbar_speed = 0.25
	elif score.text == "Score: 400":
		powerbar_speed = 0.3
	else:
		powerbar_speed = 0.35
			
func _on_timer_timeout() -> void:
	PowerBar.value += powerbar_speed
	if PowerBar.value > 9.9:
		PowerBar.value = 0
		
	var powerbar = PowerBar.value
	
	if powerbar > 0 && powerbar <= 1:
		power = 100
	elif powerbar > 1 && powerbar <= 2:
		power = 220
	elif powerbar > 2 && powerbar <= 3:
		power = 320
	elif powerbar > 3 && powerbar <= 4:
		power = 500
	elif powerbar > 4 && powerbar <= 5:
		power = 430
	elif powerbar > 5 && powerbar <= 6:
		power = 600
	elif powerbar > 6 && powerbar <= 7:
		power = 720
	elif powerbar > 7 && powerbar <= 8:
		power = 670
	elif powerbar > 8 && powerbar <= 9:
		power = 810
	elif powerbar > 9 && powerbar <= 10:
		power = 920
		
func start_power_timer():
	PowerBar.value = 0
	$Control/Timer.start()
		
func stop_power_timer():
	$Control/Timer.stop()

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

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
	
func _on_pause_button_pressed() -> void:
	if player.can_pause:
		if Global.singleplayer:
			singleplayer_mode.pauseMenu()
		else:
			multiplayer_mode.confirmationMenu()
		
func player_turn_manager():
	if Global.player1_turn:
		player = get_node("%Player1")
	elif Global.player2_turn:
		player = get_node("%Player2")
	elif Global.player3_turn:
		player = get_node("%Player3")
	elif Global.player4_turn:
		player = get_node("%Player4")		
