extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func to_level_select():
	SoundFx.button_click()
	BgMusic.battle1_bg_stop()
	SceneTransition.change_scene_to_file("res://scenes/level_select.tscn")
	BgMusic.lobby_bg_play()

