extends CharacterBody2D

var MAX_HEALTH = 1
var health = MAX_HEALTH
signal dead
signal hit

	
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
	if event.is_action_pressed("b"):
		emit_signal("hit")

	
func damage() -> void:
	health -= 1
	update_health_ui()
	if health <= 0:
		emit_signal("dead")
		
