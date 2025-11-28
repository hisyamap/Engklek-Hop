extends Node2D

@onready var player = get_node("%Player")
@onready var gaco = get_node("%Gaco")
@onready var singleplayer_mode = get_node("/root/Singleplayer/")
@onready var multiplayer_mode = get_node("/root/Multiplayer/")
@onready var turnmanager = get_node("%TurnManager")
@onready var playerlosemenu = get_node("%PlayerLose")
@onready var quiz = get_node("%QuizSystem")
@onready var world

@onready var box1 = $Box1
@onready var box2 = $Box2
@onready var box3 = $Box3
@onready var box4 = $Box4
@onready var box5 = $Box5
@onready var box6 = $Box6
@onready var box7 = $Box7
@onready var box8 = $Box8
@onready var box9 = $Box9
@onready var box10 = $Box10
@onready var boxWin = $BoxWin

var gaco_box_1 = false
var gaco_box_2 = false
var gaco_box_3 = false
var gaco_box_4 = false
var gaco_box_5 = false
var gaco_box_6 = false
var gaco_box_7 = false
var gaco_box_8 = false
var gaco_box_9 = false
var gaco_box_10 = false

var gaco_double1 = false
var gaco_double2 = false

var gaco_enter = false

var player_playing = false
var player_win = false
var win_points = 100

var change_dir_up = false
var change_dir_down = false

func _ready() -> void:
	if Global.singleplayer:
		world = singleplayer_mode
	else:
		world = multiplayer_mode
		
	if Global.currentscore != 0:
		Global.currentscore = Global.previousscore
	else:
		Global.currentscore = 0

func _physics_process(delta: float) -> void:
	if !Global.singleplayer:
		player_turn_manager()
	for body in boxWin.get_overlapping_bodies():
		if body == player && gaco_box_1 == true:
			gaco_enter = true
	for body in box1.get_overlapping_bodies():
		if body == player: 
			if player.switch_dir == false && gaco_box_2 == true:
				gaco_enter = true
	for body in box2.get_overlapping_bodies():
		if body == player:
			if player.switch_dir == false && gaco_box_3 == true:
				gaco_enter = true
			elif player.switch_dir == true && gaco_box_1 == true:
				gaco_enter = true
				gaco.can_pickup = true
				if gaco.gaco_pickedup:
					gaco_enter = false
	for body in box3.get_overlapping_bodies():
		if body == player:
			if player.switch_dir == true:
				player.direction = 0
				if gaco_box_2 == true:
					gaco_enter = true
			else:
				if gaco_box_4 == true:
					change_direction_down()
				elif gaco_box_5 == true:
					change_direction_up()
	for body in box4.get_overlapping_bodies():
		if body == player:
			if player.switch_dir == false:
				if gaco_box_6 == true:
					gaco_enter = true
			elif player.switch_dir == true:
				player.direction = 0
				if gaco_box_3 == true:
					gaco_enter = true
			if gaco_box_4 == true or gaco_box_5 == true:
				fix_direction()
	for body in box6.get_overlapping_bodies():
		if body == player:
			if player.switch_dir == true:
				player.direction = 0
				if gaco_box_4 == true:
					change_direction_down()
				elif gaco_box_5 == true:
					change_direction_up()
			elif player.switch_dir == false:
				player.direction = 0
				if gaco_box_7 == true:
					change_direction_down()
				elif gaco_box_8 == true:
					change_direction_up()
	for body in box7.get_overlapping_bodies():
		if body == player:
			if player.switch_dir == false && gaco_box_9 == true:                                      
				gaco_enter = true
			elif player.switch_dir == true && gaco_box_6 == true:
				gaco_enter = true
			if gaco_box_7 == true or gaco_box_8 == true:
				fix_direction()
	for body in box9.get_overlapping_bodies():
		if body == player:
			if player.switch_dir == true:
				if gaco_box_7 == true:
					change_direction_down()
				elif gaco_box_8 == true:
					change_direction_up()
			elif player.switch_dir == false:
				player.direction = 0
	for body in box10.get_overlapping_bodies():
		if body == player && gaco_box_9 == true:
			gaco_enter = true
			
## BOX 1
func _on_box_1_body_entered(body):
	print("entered box 1")
	if body == gaco:
		gaco_box_1 = true
		quiz.start_quiz()
	if body == player && player.twolegsjump == true:
		if gaco_box_1 == false:
			Global.lose_condition = 1
			player_lose()
			
	if body == player:
		if player_playing:
			player_win = true
		else:
			is_player_playing()
		
func _on_box_1_body_exited(body):
	if body == player:
		gaco_enter = false

## BOX 2
func _on_box_2_body_entered(body):
	print("entered box 2")
	if body == gaco:
		gaco_box_2 = true
		quiz.start_quiz()
	if gaco_box_2 == false:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()
		
func _on_box_2_body_exited(body):
	if body == player:
		gaco_enter = false
		
## BOX 3
func _on_box_3_body_entered(body):
	print("entered box 3")
	if body == gaco:
		gaco_box_3 = true
		quiz.start_quiz()
	if gaco_box_3 == false:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()

func _on_box_3_body_exited(body):
	if body == player:
		gaco_enter = false

## BOX 4
func _on_box_4_body_entered(body):
	print("entered box 4")
	if body == player && gaco_double1 == false:
		if player.onelegjump == true:
			Global.lose_condition = 1
			player_lose()
		player.twolegs = true
	elif body == gaco:
		gaco_double1 = true
		gaco_box_4 = true
		quiz.start_quiz()
	elif gaco_double1 == true:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()

func _on_box_4_body_exited(body):
	if body == player:
		player.twolegs = false
		player.direction = 0

## BOX 5
func _on_box_5_body_entered(body):
	print("entered box 5")
	if body == player && gaco_double1 == false:
		if player.onelegjump == true:
			Global.lose_condition = 1
			player_lose()
		player.twolegs = true
	elif body == gaco:
		gaco_double1 = true
		gaco_box_5 = true
		quiz.start_quiz()
	elif gaco_double1 == true:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()

func _on_box_5_body_exited(body: Node2D) -> void:
	if body == player:
		gaco_enter = false
		player.direction = 0

## BOX 6
func _on_box_6_body_entered(body):
	print("entered box 6")
	if body == gaco:
		gaco_box_6 = true
		quiz.start_quiz()
	if gaco_box_6 == false:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()

func _on_box_6_body_exited(body: Node2D) -> void:
	if body == player:
		gaco_enter = false
		player.direction = 0

## BOX 7
func _on_box_7_body_entered(body):
	print("entered box 7")
	if body == player && gaco_double2 == false:
		if player.onelegjump == true:
			Global.lose_condition = 1
			player_lose()
		player.twolegs = true
	elif body == gaco:
		gaco_double2 = true
		gaco_box_7 = true
		quiz.start_quiz()
	elif gaco_double2 == true:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()

func _on_box_7_body_exited(body):
	if body == player:
		player.twolegs = false
		player.direction = 0

## BOX 8
func _on_box_8_body_entered(body):
	print("entered box 8")
	if body == player && gaco_double2 == false:
		if player.onelegjump == true:
			Global.lose_condition = 1
			player_lose()
		player.twolegs = true
	elif body == gaco:
		gaco_double2 = true
		gaco_box_8 = true
		quiz.start_quiz()
	elif gaco_double2 == true:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()

func _on_box_8_body_exited(body: Node2D) -> void:
	if body == player:
		gaco_enter = false
		player.direction = 0
		
## BOX 9
func _on_box_9_body_entered(body):
	print("entered box 9")
	if body == gaco:
		gaco_box_9 = true
		quiz.start_quiz()
	if gaco_box_9 == false:
		if body == player && player.twolegsjump == true:
			Global.lose_condition = 1
			player_lose()
	if gaco_box_10 == true:
		player.switch_direction()
		gaco.can_pickup = true

func _on_box_9_body_exited(body: Node2D) -> void:
	if body == player:
		gaco_enter = false
		player.direction = 0
		if player.twolegsjump:
			player.twolegs = true

## BOX 10
func _on_box_10_body_entered(body):
	print("entered box 10")
	if body == gaco:
		gaco_box_10 = true
		quiz.start_quiz()
	if body == player:
		player.switch_direction()

func _on_box_10_body_exited(body: Node2D) -> void:
	if body == player:
		gaco_enter = false

func _on_box_win_body_entered(body):
	print("entered box win")
	if body == player && player_win:
		player_win = false
		if gaco.gaco_pickedup:
			await get_tree().create_timer(0.3).timeout
			MusicSfx.level_passed()
			update_score()
			if !Global.singleplayer:
				reset_level()
				reset_gaco_position()
				gaco.reset_gaco()
				player.reset_player()
				player.position = Vector2(0,0)
			world.levelpassedMenu()
		elif player_playing:
			Global.lose_condition = 2
			player_lose()
			 
func is_player_playing():
	player_playing = true
	
func update_score():
	if Global.singleplayer:
		Global.currentscore += win_points
	else:
		if Global.player1_turn:
			Global.player1_score += win_points
		elif Global.player2_turn:
			Global.player2_score += win_points
		elif Global.player3_turn:
			Global.player3_score += win_points
		elif Global.player4_turn:
			Global.player4_score += win_points

func player_lose():
	if Global.singleplayer:
		MusicSfx.gameover()
		get_tree().change_scene_to_file("res://gameover_menu.tscn")
	else:
		MusicSfx.game_lose()
		playerlosemenu.update_score()
		reset_level()
		player.disable_player()
		world.playerloseMenu()
		player.visible = false
		turnmanager.end_turn()
		reset_gaco_position()
		gaco.reset_gaco()
	
func change_direction_up():
	player.direction = -2
	change_dir_up = true

func change_direction_down():
	player.direction = 2
	change_dir_down = true

func fix_direction():
	print("fixed direction")
	if change_dir_up == true:
		player.direction = 2
		change_dir_up == false
	elif change_dir_down == true:
		player.direction = -2
		change_dir_down == false
		
func player_turn_manager():
	if Global.player1_turn:
		player = get_node("%Player1")
	elif Global.player2_turn:
		player = get_node("%Player2")
	elif Global.player3_turn:
		player = get_node("%Player3")
	elif Global.player4_turn:
		player = get_node("%Player4")

func reset_level():
	gaco_box_1 = false
	gaco_box_2 = false
	gaco_box_3 = false
	gaco_box_4 = false
	gaco_box_5 = false
	gaco_box_6 = false
	gaco_box_7 = false
	gaco_box_8 = false
	gaco_box_9 = false
	gaco_box_10 = false
	gaco_double1 = false
	gaco_double2 = false
	gaco_enter = false
	player_playing = false
	change_dir_up = false	
	change_dir_down = false

func reset_gaco_position():
	gaco.position = Vector2(209,398)
