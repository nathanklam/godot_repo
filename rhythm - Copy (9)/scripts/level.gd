extends Node2D

var battleBg
func _ready():
	var scene = get_tree().get_current_scene().get_name()
	#selecting the music for the level
	if scene == "tutorial":
		var battleBg = BgMusic.get_node("battle1_bg")
		self.battleBg = battleBg
	elif scene == "secret_battle":
		var battleBg = BgMusic.get_node("secret_battle_bg")
		self.battleBg = battleBg
	#this causes the midi file to "play", which will then result in notes being created
	$MidiPlayerEnemy.play()
	$MidiPlayerPlayer.play()
	
var stop = false
var delta_sum = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var time = battleBg.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency (apparently).
	# why the hell does this not work as intended? prints weird stuff
	#time -= AudioServer.get_output_latency()
	#print("Time is: ", time)
	delta_sum += delta
	#print(delta_sum)
	
	#issue might be here.
	#why the hell does it not stop for the secret battle version if it works for the regular tutorial
	if delta_sum >= 3.3 and not battleBg.playing and stop == false:
		battleBg.play()
	#the delta_sum thing was estimated in order to sync the background music with the "notes"

#  below are to be copied onto different levels. should probably make this part of the pause script but yeah
func pause():
	get_tree().paused = true
	$pause_menu.show()

func unpause(): #this has to be the worst countdown timer workaround ever
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

func _on_quit_pressed(): #on the pause menu
	$pause_menu.hide()
	$lose_screen.show()

#the scene transition for this function doesn't work properly.
func _on_to_level_select_pressed(): #on the lose overlay and the win overlay
	print("attempt transition")
	stop = true #this is supposed to guarentee stopping the music but it doesnt work for the secret battle (WHY????)
	LoseScreen.to_level_select() # it used to work fine, might have accidentally broke something
	#check older versions when it worked

	$input_stop.show()
	await get_tree().create_timer(1.5).timeout
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause()

func _on_character_body_2d_dead():
	get_tree().paused = true
	stop = true
	$win_screen.show()

func _on_main_character_dead():
	get_tree().paused = true
	stop = true
	$lose_screen.show()
	
var x = 0
var y = 0
var defend = false
#rename to separate
var can_hit_enemy = false
var can_hit_player = true

#midi players dont loop properly
func _on_tutorial_enemy_hit():
	if can_hit_enemy == true:
		#have to make sure this can only happen once
		$tutorial_enemy.damage()

func _on_main_character_hit():
	#the idea is to mitigate damage if done in time, think of better way
	if can_hit_player == true:
		defend = true
		#also of course doing things this way is kind of dumb
		await get_tree().create_timer(1).timeout
		defend = false

func _on_midi_player_player_midi_event(channel, event):
	var i = preload("res://scenes/note.tscn").instantiate()
	add_child(i)
	i.global_position.x = 2000
	i.global_position.y = 200

func _on_midi_player_enemy_midi_event(channel, event):
	var i = preload("res://scenes/note.tscn").instantiate()
	add_child(i)
	i.global_position.x = 2000
	i.global_position.y = 300
	

#REDO THE COLLISION STUFF IT KINDA SUCKS
func _on_area_2d_body_entered(body):
	can_hit_enemy = true

func _on_area_2d_body_exited(body):
	can_hit_enemy = false

func _on_area_2d2_body_entered(body):
	can_hit_player = true
	
func _on_area_2d2_body_exited(body):
	if defend == false:
		$main_character.damage()
	can_hit_player = false

#specifcally for secret battle
func _on_shopkeep_dead():
	get_tree().paused = true
	$win_screen.show()

func _on_shopkeep_hit():
	if can_hit_enemy == true:
		#have to make sure this can only happen once within the time interval of which damage can be done
		$shopkeep.damage()
