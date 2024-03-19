extends CharacterBody2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.x = -500
	move_and_slide()

