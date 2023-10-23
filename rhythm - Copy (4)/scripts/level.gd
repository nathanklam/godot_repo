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
	$pause_menu/continue.hide()
	$pause_menu/paused.hide()
	$pause_menu/quit.hide()
	$pause_menu/countdown.show()
	var timer = get_tree().create_timer(3.0)
	$pause_menu/countdown.text = str(round(timer.time_left))
	await get_tree().create_timer(1.0).timeout
	$pause_menu/countdown.text = str(round(timer.time_left))
	await get_tree().create_timer(1.0).timeout
	$pause_menu/countdown.text = str(round(timer.time_left))
	await get_tree().create_timer(1.0).timeout
	#god awful workaround but it works
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
	get_tree().paused = false
	LoseScreen.to_level_select()
	#doesn't matter if win or lose screen, kinda duplicated it on accident i think 
	#why is it broken in the secret battle one
	$input_stop.show()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause()

func _on_character_body_2d_dead():
	get_tree().paused = true
	$win_screen.show()
