extends CanvasLayer

@onready var level = get_node("%LevelType1")
@onready var player = get_node("%Player")
@onready var correct_answer = $CorrectAnswerPopup
@onready var wrong_answer = $WrongAnswerPopup

func _physics_process(delta: float) -> void:
	if !Global.singleplayer:
		player_turn_manager()
		
func start_quiz(): 
	if Global.category == 1:
		start_presenttense_quiz()
	elif Global.category == 2:
		start_pasttense_quiz()
	elif Global.category == 3:
		start_continoustense_quiz()
	elif Global.category == 4:
		start_perfecttense_quiz()
	
func start_presenttense_quiz():
	if level.gaco_box_1 == true:
		Dialogic.start("questions_1")
	elif level.gaco_box_2 == true:
		Dialogic.start("questions_2")
	elif level.gaco_box_3 == true:
		Dialogic.start("questions_3")
	elif level.gaco_box_4 == true:
		Dialogic.start("questions_4")
	elif level.gaco_box_5 == true:
		Dialogic.start("questions_5")
	elif level.gaco_box_6 == true:
		Dialogic.start("questions_6")
	elif level.gaco_box_7 == true:
		Dialogic.start("questions_7")
	elif level.gaco_box_8 == true:
		Dialogic.start("questions_8")
	elif level.gaco_box_9 == true:
		Dialogic.start("questions_9")
	elif level.gaco_box_10 == true:
		Dialogic.start("questions_10")
	Dialogic.signal_event.connect(question_randomizer)
		
func start_pasttense_quiz():
	if level.gaco_box_1 == true:
		Dialogic.start("pasttense_1")
	elif level.gaco_box_2 == true:
		Dialogic.start("pasttense_2")
	elif level.gaco_box_3 == true:
		Dialogic.start("pasttense_3")
	elif level.gaco_box_4 == true:
		Dialogic.start("pasttense_4")
	elif level.gaco_box_5 == true:
		Dialogic.start("pasttense_5")
	elif level.gaco_box_6 == true:
		Dialogic.start("pasttense_6")
	elif level.gaco_box_7 == true:
		Dialogic.start("pasttense_7")
	elif level.gaco_box_8 == true:
		Dialogic.start("pasttense_8")
	elif level.gaco_box_9 == true:
		Dialogic.start("pasttense_9")
	elif level.gaco_box_10 == true:
		Dialogic.start("pasttense_10")
	Dialogic.signal_event.connect(question_randomizer)

func start_continoustense_quiz():
	if level.gaco_box_1 == true:
		Dialogic.start("continous_1")
	elif level.gaco_box_2 == true:
		Dialogic.start("continous_2")
	elif level.gaco_box_3 == true:
		Dialogic.start("continous_3")
	elif level.gaco_box_4 == true:
		Dialogic.start("continous_4")
	elif level.gaco_box_5 == true:
		Dialogic.start("continous_5")
	elif level.gaco_box_6 == true:
		Dialogic.start("continous_6")
	elif level.gaco_box_7 == true:
		Dialogic.start("continous_7")
	elif level.gaco_box_8 == true:
		Dialogic.start("continous_8")
	elif level.gaco_box_9 == true:
		Dialogic.start("continous_9")
	elif level.gaco_box_10 == true:
		Dialogic.start("continous_10")
	Dialogic.signal_event.connect(question_randomizer)

func start_perfecttense_quiz():
	if level.gaco_box_1 == true:
		Dialogic.start("perfecttense_1")
	elif level.gaco_box_2 == true:
		Dialogic.start("perfecttense_2")
	elif level.gaco_box_3 == true:
		Dialogic.start("perfecttense_3")
	elif level.gaco_box_4 == true:
		Dialogic.start("perfecttense_4")
	elif level.gaco_box_5 == true:
		Dialogic.start("perfecttense_5")
	elif level.gaco_box_6 == true:
		Dialogic.start("perfecttense_6")
	elif level.gaco_box_7 == true:
		Dialogic.start("perfecttense_7")
	elif level.gaco_box_8 == true:
		Dialogic.start("perfecttense_8")
	elif level.gaco_box_9 == true:
		Dialogic.start("perfecttense_9")
	elif level.gaco_box_10 == true:
		Dialogic.start("perfecttense_10")
	Dialogic.signal_event.connect(question_randomizer)
	
func question_randomizer(argument:String):
	if argument == "random":
		var random_number = randi_range(1, 10)
		Dialogic.VAR.set('question', random_number)

	if argument == "correct":
		correct_answer.show()
		$AnimationPlayer.play("correct_answer_popup")
		await get_tree().create_timer(0.2).timeout
		MusicSfx.correct_answer()
		await get_tree().create_timer(1.3).timeout
		correct_answer.hide()
		player.game_start = true
	elif argument == "wrong":
		wrong_answer.show()
		$AnimationPlayer.play("wrong_answer_popup")
		await get_tree().create_timer(0.2).timeout
		MusicSfx.wrong_answer()
		await get_tree().create_timer(1.3).timeout
		wrong_answer.hide()
		level.player_lose()

func player_turn_manager():
	if Global.player1_turn:
		player = get_node("%Player1")
	if Global.player2_turn:
		player = get_node("%Player2")
	if Global.player3_turn:
		player = get_node("%Player3")
	if Global.player4_turn:
		player = get_node("%Player4")
