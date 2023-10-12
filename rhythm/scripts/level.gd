extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#  below are to be copied onto different levels. should probably make this part of the pause script but yeah
func pause():
	get_tree().paused = true
	$pause_menu.show()

func unpause():
	$pause_menu/overlay.hide()
	$pause_menu/continue.hide()
	$pause_menu/paused.hide()
	$pause_menu/quit.hide()
	await get_tree().create_timer(3.0).timeout
	$pause_menu.hide()
	# 3 sec delay to go back in (makes sense for games like this), show it in some way 
	get_tree().paused = false

func _on_quit_pressed():
	$pause_menu.hide()
	$lose_screen.show()

func _on_to_level_select_pressed():
	#SoundFx.button_click()
	LoseScreen.to_level_select()
	get_tree().paused = false
	#SceneTransition.change_scene_to_file("res://scenes/level_select.tscn")
	#BgMusic.play()
