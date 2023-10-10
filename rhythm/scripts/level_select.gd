extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_to_lobby_pressed():
	SoundFx.button_click()
	$input_stop.show()
	SceneTransition.change_scene_to_file("res://scenes/lobby.tscn")
	
	
func _on_to_tutorial_pressed():
	SoundFx.button_click()
	$input_stop.show()
	SceneTransition.change_scene_to_file("res://scenes/tutorial.tscn")



func _on_level_1_pressed():
	#SoundFx.note_miss()
	pass
