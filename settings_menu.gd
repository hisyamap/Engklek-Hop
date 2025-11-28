extends Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var back: Button = $BackButton

func _ready() -> void:
	$MusicBar.value = MusicSfx.config.get_value("Audio", '1')
	AudioServer.set_bus_volume_db(1, linear_to_db($MusicBar.value))
	
	$SoundBar.value = MusicSfx.config.get_value("Audio", '2')
	AudioServer.set_bus_volume_db(2, linear_to_db($SoundBar.value))
	
	var music_mute = MusicSfx.config.get_value("Mute Audio","music")
	if music_mute:
		$MuteMusic.button_pressed = true
	
	var sound_mute = MusicSfx.config.get_value("Mute Audio","sound")
	if sound_mute:
		$MuteSound.button_pressed = true

func _process(delta: float) -> void:
	button_hovered(back)
	
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_back_button_pressed() -> void:
	MusicSfx.button_click()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func set_volume(index, value):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
	MusicSfx.config.set_value("Audio", str(index), value)
	MusicSfx.save_data()

func _on_music_bar_value_changed(value: float) -> void:
	set_volume(1, value)

func _on_sound_bar_value_changed(value: float) -> void:
	set_volume(2, value)

func _on_mute_music_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, toggled_on)
	MusicSfx.config.set_value("Mute Audio", "music", toggled_on)
	MusicSfx.save_data()

func _on_mute_sound_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2, toggled_on)
	MusicSfx.config.set_value("Mute Audio", "sound", toggled_on)
	MusicSfx.save_data()
