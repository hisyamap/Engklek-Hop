extends Node

# Array to hold players or entities that will take turns
var players = []
var current_turn = -1
var TOTAL_PLAYERS

# Signal to notify when a turn changes
signal turn_changed

func _ready():
	set_number_of_player()
	
	_next_turn()

func _next_turn():
	if players.size() == 0:
		print("No players available for turns.")
		return
	
	if current_turn >= TOTAL_PLAYERS:
		Global.game_finished = true
	else:
		current_turn = (current_turn + 1)
		var current_player = players[current_turn]
		
		current_player.start_turn()
		print(players[current_turn].name + "'s turn has started.")
		
		if players[current_turn].name == "Player1":
			Global.player1_turn = true
		elif players[current_turn].name == "Player2":
			Global.player2_turn = true
		elif players[current_turn].name == "Player3":
			Global.player3_turn = true
		elif players[current_turn].name == "Player4":
			Global.player4_turn = true
		
		emit_signal("turn_changed", current_player)
	
func end_turn():
	Global.player1_turn = false
	Global.player2_turn = false
	Global.player3_turn = false
	Global.player4_turn = false
			
	print(players[current_turn].name + "'s turn has ended.")
	_next_turn()

func set_number_of_player():
	# List of player names and corresponding player nodes
	var player_names = [
		Global.player1_name,
		Global.player2_name,
		Global.player3_name,
		Global.player4_name
	]
	
	var player_nodes = [
		$Player1,
		$Player2,
		$Player3,
		$Player4
	]

	# Count valid players and append to players array
	for i in range(player_names.size()):
		if player_names[i] != "":
			players.append(player_nodes[i])
			
	# Set the total number of players
	TOTAL_PLAYERS = players.size()-1
