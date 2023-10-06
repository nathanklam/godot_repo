extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pause():
	get_tree().paused = true
	$pause_menu.show()

func unpause():
	$pause_menu.hide()
	get_tree().paused = false
	# 3 sec delay to go back in (makes sense for games like this), show it in some way 
	# I guess
	
func _on_quit_pressed():
	$pause_menu.hide()
	$lose_screen.show()

func _on_to_level_select_pressed():
	get_tree().paused = false
	SceneTransition.change_scene_to_file("res://scenes/level_select.tscn")
