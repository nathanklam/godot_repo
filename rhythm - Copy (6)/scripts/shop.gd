extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button_presses == 10 and transition == true:
		scene_transition()
		transition = false
		
var button_presses = 0
var transition = true

func _on_to_lobby_pressed():
	SoundFx.button_click()
	SceneTransition.change_scene_to_file("res://scenes/lobby.tscn")
	$input_stop.show()
	
func _on_to_secret_pressed():
	SoundFx.button_click()
	button_presses += 1

	
func scene_transition():
	SceneTransition.change_scene_to_file("res://scenes/secret_battle.tscn")
	$input_stop.show()
	await get_tree().create_timer(1.5).timeout
	BgMusic.lobby_bg_stop()

	
