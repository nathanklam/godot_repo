extends Node2D

var battleBg
# Called when the node enters the scene tree for the first time.
func _ready():
	BgMusic.battle1_bg_play()
	var battleBg = BgMusic.get_node("battle1_bg")
	self.battleBg = battleBg
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = battleBg.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency (apparently).
	# why the hell does this not work as intended? prints weird stuff
	#time -= AudioServer.get_output_latency()
	print("Time is: ", time)


#  below are to be copied onto different levels. should probably make this part of the pause script but yeah
func pause():
	get_tree().paused = true
	$pause_menu.show()
#can probably get the rest to be on its own scene
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

var x = 0
var y = 0
#rename to separate
var can_hit = false

#midi players dont loop properly
func _on_midi_player_midi_event(channel, event):
	x += 1
	print("enemy", x)
	#just to visualize and testss
	$Note2.show()
	await get_tree().create_timer(0.2).timeout
	$Note2.hide()
	
func _on_midi_player_2_midi_event(channel, event):
	#y += 1
	#print("player", y) 
	
	#this is so stupid but it "works" hahahahaha
	#only works after though, no time before
	can_hit = true
	print("hit")
	$Note.show()
	await get_tree().create_timer(0.2).timeout
	can_hit = false
	print("unhit") 
	$Note.hide()

func _on_tutorial_enemy_hit():
	if can_hit == true:
		#have to make sure this can only happen once
		$tutorial_enemy.damage()
