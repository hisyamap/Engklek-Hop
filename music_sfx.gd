extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()
var musicplayed = false

func _ready() -> void:
	config.set_value("Mute Audio", "music", false)
	config.set_value("Mute Audio", "sound", false)
	
	config.set_value("Audio", str(0), 1)
	config.set_value("Audio", str(1), 0.8)
	config.set_value("Audio", str(2), 1)
		
	load_data()

func save_data():
	config.save(PATH)
	
func load_data():
	if config.load("user://settings.cfg") != OK:
		save_data()
		return
		
	var music_mute = config.get_value("Mute Audio", "music")
	AudioServer.set_bus_mute(1, music_mute)
		
	var sound_mute = config.get_value("Mute Audio", "sound")
	AudioServer.set_bus_mute(2, sound_mute)
	
	
func play_maintheme_music():
	if !musicplayed:
		$MainThemeMusic.play() 
		musicplayed = true

func stop_maintheme_music():
	musicplayed = false
	$MainThemeMusic.stop()	

func button_click():
	$ButtonPressedSound.play()

func level_passed():
	$LevelPassedSound.play()
	
func correct_answer():
	$CorrectAnswerSound.play()
	
func wrong_answer():
	$WrongAnswerSound.play()

func game_lose():
	$GameLoseSound.play()
	
func gameover():
	$GameoverSound.play()
