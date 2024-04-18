extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lobby_bg_play():
	$lobby_bg.play()
	
func lobby_bg_stop():
	$lobby_bg.stop()
	
func battle1_bg_play():
	$battle1_bg.play()
	
func battle1_bg_stop():
	$battle1_bg.stop()
	
func secret_battle_play():
	$secret_battle_bg.play()
	
func secret_battle_stop():
	$secret_battle_bg.stop()

