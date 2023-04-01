extends RigidBody2D

@export var max_speed = 700.0
@export var deceleration = 50.0

var risingSpeed = 50

func _ready() -> void:
	new_game()
	
func new_game() -> void:
	position = get_global_mouse_position()

func _physics_process(delta):
	
	risingSpeed = get_parent().score*3
	
	var target_position = get_global_mouse_position()

	var direction = (target_position - position).normalized()
	var distance = (target_position - position).length()

	var speed_ratio = 1.0
	if distance < deceleration:
		speed_ratio = distance / deceleration

	var speed = max_speed * speed_ratio
	linear_velocity = direction * speed
