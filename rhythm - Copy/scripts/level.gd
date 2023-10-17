extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$win_screen.hide()
	#await $CharacterBody2D/healthbar.value == 0
	#$win_screen.show()
	pass
	
#  below are to be copied onto different levels. should probably make this part of the pause script but yeah
func pause():
	get_tree().paused = true
	$pause_menu.show()
	

	
func unpause():
	$pause_menu/continue.hide()
	$pause_menu/paused.hide()
	$pause_menu/quit.hide()
	$pause_menu/countdown.show()
	var test = get_tree().create_timer(3.0)
	$pause_menu/countdown.text = str(round(test.time_left))
	await get_tree().create_timer(1.0).timeout
	$pause_menu/countdown.text = str(round(test.time_left))
	await get_tree().create_timer(1.0).timeout
	$pause_menu/countdown.text = str(round(test.time_left))
	await get_tree().create_timer(1.0).timeout
	#god awful workaround but it should work
	$pause_menu.hide()
	$pause_menu/countdown.hide()
	$pause_menu/continue.show()
	$pause_menu/paused.show()
	$pause_menu/quit.show()
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

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause()
		
func _on_timer_timeout():
	# This function will be called when the timer expires.
	pass  # You can add specific actions you want to perform when the timer expires here

