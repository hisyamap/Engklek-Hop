extends CharacterBody2D

@onready var animated_sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var animTree = $AnimationTree
@onready var sprite = $Sprite2D
@onready var jumpsound = $JumpingSound
@onready var gaco = get_node("%Gaco")
@onready var level = get_node("%LevelType1")

const tile_size = 16
var distance = 7.6
var direction = 0
var input_dir
var is_moving = false
var is_jumping = false
var switch_dir = false
var twolegs = true
var onelegjump = false
var twolegsjump = false
var can_jump = true
var game_start: bool = false
var can_pause = true

func _ready() -> void:
	if !Global.singleplayer:
		self.hide()
		disable_collision()

func _physics_process(delta):
	input_dir = Vector2.ZERO
	if gaco.can_throw && Input.is_action_just_pressed("throwpickupgaco"):
		can_pause = false
		anim.play("throw_gaco")
		await get_tree().create_timer(1.5).timeout
		anim.play("Idle")
	#elif gaco.can_pickup && Input.is_action_just_pressed("throwpickupgaco"):
		#sprite.flip_h = false
		#anim.play("pickup_gaco")
		#await get_tree().create_timer(1).timeout
		#sprite.flip_h = true
	 
	if game_start == true:
		can_pause = true
		if can_jump && Input.is_action_just_pressed("onelegjump"):
			can_jump = false
			if twolegs == true && is_jumping == false:
				twolegs = false
				is_jumping = true
				anim.play("Jump_twoone")
				player_jump()
			elif twolegs == false && is_jumping == false:
				is_jumping = true
				anim.play("Jump_oneone")
				player_jump()
			elif is_jumping == false:
				twolegs = false
				is_jumping = true
				anim.play("Jump_twoone")
				player_jump()
			$Timer.start()
			onelegjump = true
			twolegsjump = false
			
		elif can_jump && Input.is_action_just_pressed("twolegsjump"):
			can_jump = false
			if twolegs == false && is_jumping == false:
				is_jumping = true
				anim.play("Jump_onetwo")
				player_jump()
			elif twolegs == true && is_jumping == false:
				is_jumping = true
				anim.play("Jump_twotwo")
				player_jump()
			$Timer.start()
			onelegjump = false
			twolegsjump = true
		move_and_slide()

func move():
	if input_dir:
		if is_moving == false:
			is_moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*tile_size, 1.0)
			tween.tween_callback(move_false)
		is_jumping = false
			
func player_jump():
	await get_tree().create_timer(0.3).timeout
	if switch_dir == true:
		if level.gaco_enter == false:
			distance = -7.2
		if level.gaco_enter == true:
			distance = -14.4
	elif switch_dir == false: 
		if level.gaco_enter == false:
			distance = 7.6
		if level.gaco_enter == true:
			distance = 15.2
	input_dir = Vector2(distance, direction)
	move()
	await get_tree().create_timer(0.2).timeout
	jumpsound.play()
		
func move_false():
	is_moving = false

func switch_direction():
	switch_dir = true
	await get_tree().create_timer(0.3).timeout
	sprite.flip_h = true
	
func _on_timer_timeout() -> void:
	can_jump = true

func start_turn():
	reset_player()
	self.show()
	process_mode = self.PROCESS_MODE_INHERIT
	$CollisionShape2D.set_deferred("disabled", false)

func disable_player():
	process_mode = self.PROCESS_MODE_DISABLED
	
func disable_collision():
	$CollisionShape2D.set_deferred("disabled", true)

func reset_player():
	sprite.flip_h = false
	switch_dir = false
	twolegs = true
	onelegjump = false
	twolegsjump = false
	can_jump = true
	game_start = false
