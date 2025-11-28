extends Node2D

@onready var levelpassedmenu = $MenuCanvas/LevelPassedMenu
@onready var playerlosemenu = $MenuCanvas/PlayerLose
@onready var confirmantionmenu = $MenuCanvas/ConfirmationMenu
@onready var turnmanager = get_node("%TurnManager")
var paused = false
var player

func _ready() -> void:
	MusicSfx.stop_maintheme_music()
	$GameplayMusic.play()
		
func _process(delta: float) -> void:
	player_turn_manager()
	if player.can_pause && Input.is_action_just_pressed("pausegame"):
		confirmationMenu()
		
func levelpassedMenu():
	if paused:
		levelpassedmenu.hide()
		get_tree().paused = false
	else:
		levelpassedmenu.show()
		get_tree().paused = true
		
	paused = !paused

func playerloseMenu():
	if paused:
		playerlosemenu.hide()
		get_tree().paused = false
	else:
		playerlosemenu.show()
		get_tree().paused = true
		
	paused = !paused

func confirmationMenu():
	if paused:
		confirmantionmenu.hide()
		get_tree().paused = false
	else:
		confirmantionmenu.show()
		get_tree().paused = true
		
	paused = !paused

func player_turn_manager():
	if Global.player1_turn:
		player = get_node("%Player1")
	elif Global.player2_turn:
		player = get_node("%Player2")
	elif Global.player3_turn:
		player = get_node("%Player3")
	elif Global.player4_turn:
		player = get_node("%Player4")
