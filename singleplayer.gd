extends Node2D

@onready var pausemenu = $MenuCanvas/PauseMenu
@onready var levelpassedmenu = $MenuCanvas/LevelPassedMenu
@onready var player = $Player
var paused = false

func _ready() -> void:
	MusicSfx.stop_maintheme_music()
	$GameplayMusic.play()

func _process(delta: float) -> void:
	if player.can_pause && Input.is_action_just_pressed("pausegame"):
		pauseMenu()
	
func pauseMenu():
	if paused:
		pausemenu.hide()
		get_tree().paused = false
	else:
		pausemenu.show()
		get_tree().paused = true
		
	paused = !paused
		
func levelpassedMenu():
	if paused:
		levelpassedmenu.hide()
		get_tree().paused = false
	else:
		levelpassedmenu.show()
		get_tree().paused = true
		
	paused = !paused
