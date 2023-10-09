extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_to_shop_pressed():
	$input_stop.show()
	SceneTransition.change_scene_to_file("res://scenes/shop.tscn")
	
func _on_to_level_select_pressed():
	$input_stop.show()
	SceneTransition.change_scene_to_file("res://scenes/level_select.tscn")



