extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_to_lobby_pressed():
	SoundFx.button_click()
	SceneTransition.change_scene_to_file("res://scenes/lobby.tscn")
	$input_stop.show()
	
func _on_to_secret_pressed():
	SoundFx.button_click()
	SceneTransition.change_scene_to_file("res://scenes/secret_battle.tscn")
	$input_stop.show()
