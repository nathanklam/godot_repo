extends CanvasLayer

func _ready():
	pass
	
#func _process(delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		$AnimationPlayer.play("fade_to_black")
		
func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.play("fade_to_black")
#	await $AnimationPlayer.animation_finished()
	await get_tree().create_timer(1.5).timeout
	#it works but like what happens if the game needs to load????? WHY WONT THE ABOVE WORK (animation_finished thing)
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("fade_to_black")
