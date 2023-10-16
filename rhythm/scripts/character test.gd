extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity * delta)/100

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

const MAX_HEALTH = 5
var health = MAX_HEALTH

func _ready() -> void:
	update_health_ui()
	$healthbar.max_value = MAX_HEALTH

func update_health_ui():
	set_health_label()
	set_health_bar()

func set_health_label() -> void:
	$healthlabel.text = "Health: %s" % health

func set_health_bar() -> void:
	$healthbar.value = health

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		print("Enter key pressed")  # Add this line for debugging
		damage()
	
func damage() -> void:
	health -= 1
	print(health)
	if health < 0:
		health = MAX_HEALTH
		update_health_ui()
