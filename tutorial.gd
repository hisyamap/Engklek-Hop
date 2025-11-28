extends Node2D

func _ready() -> void:
	Dialogic.start("tutorial")
	Dialogic.signal_event.connect(tutorial_completed)
	
func tutorial_completed(argument:String):
	if argument == "completed":
		get_tree().change_scene_to_file("res://tutorial_completed_menu.tscn")
