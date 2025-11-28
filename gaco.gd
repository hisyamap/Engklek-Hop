extends RigidBody2D

var can_pickup = false
var can_throw = true
var powerbar = true
var gaco_pickedup = false
var hide = false
@onready var sprite = $Sprite2D
@onready var throwsound = $ThrowingSound
@onready var pickupsound = $PickupSound
@onready var player = get_node("%Player")
@onready var gameUI = get_node("%GameUI")
@onready var area = $Area2D

func _physics_process(delta):
	var strength = gameUI.power
	if  can_throw && Input.is_action_just_pressed("throwpickupgaco"):
		gameUI.stop_power_timer()
		can_throw = false
		await get_tree().create_timer(0.95).timeout
		powerbar = false
		sprite.visible = true
		throwsound.play()
		apply_central_impulse(Vector2(strength, -400))
	elif can_pickup && Input.is_action_just_pressed("throwpickupgaco"):
		sprite.visible = false
		can_pickup = false
		gaco_pickedup = true
		pickupsound.play()
	
	if !Global.singleplayer:
		player_turn_manager()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		if player.switch_dir:
			print("player can pickup")
			can_pickup = true
		else:
			can_pickup = false

func player_turn_manager():
	if Global.player1_turn:
		player = get_node("%Player1")
	elif Global.player2_turn:
		player = get_node("%Player2")
	elif Global.player3_turn:
		player = get_node("%Player3")
	elif Global.player4_turn:
		player = get_node("%Player4")

func reset_gaco():
	sprite.visible = false
	can_throw = true
	can_pickup = false
	powerbar = true
	gaco_pickedup = false
	gameUI.start_power_timer()
