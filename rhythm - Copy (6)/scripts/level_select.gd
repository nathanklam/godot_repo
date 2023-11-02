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
	$details.show()

func _on_close_pressed():
	$details.hide()

func _on_level_1_pressed():
	SoundFx.note_miss()

func _on_button_pressed():
	SoundFx.button_click()
	$input_stop.show()
	SceneTransition.change_scene_to_file("res://scenes/tutorial.tscn")
	await get_tree().create_timer(0.5).timeout
	BgMusic.lobby_bg_stop()
