extends Node

var present_highscore:int = 0
var past_highscore:int = 0
var continous_highscore:int = 0
var perfect_highscore:int = 0
var currentscore: int
var previousscore: int

var player1_name: String
var player2_name: String
var player3_name: String
var player4_name: String

var player1_turn: bool
var player2_turn: bool
var player3_turn: bool
var player4_turn: bool

var player1_score: int
var player2_score: int
var player3_score: int
var player4_score: int

var singleplayer: bool
var game_finished: bool

var category: int
var lose_condition: int

const SAVEFILE = "user://savefile.save"

func _ready():
	load_score()
 
func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_32(present_highscore)
	file.store_32(past_highscore)
	file.store_32(continous_highscore)
	file.store_32(perfect_highscore)
	file = null
 
func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE):
		present_highscore = file.get_32()
		past_highscore = file.get_32()
		continous_highscore = file.get_32()
		perfect_highscore = file.get_32()
	file = null
	
