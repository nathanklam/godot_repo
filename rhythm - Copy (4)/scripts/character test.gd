extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity * delta)/100
	move_and_slide()

var MAX_HEALTH = 5
var health = MAX_HEALTH
signal dead
	
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
	update_health_ui()
	if health <= 0:
		emit_signal("dead")
		
