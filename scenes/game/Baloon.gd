extends RigidBody2D

var max_speed = 700.0
var deceleration = 50.0

func _physics_process(delta):
	var target_position = get_global_mouse_position()

	var direction = (target_position - position).normalized()
	var distance = (target_position - position).length()

	var speed_ratio = 1.0
	if distance < deceleration:
		speed_ratio = distance / deceleration

	var speed = max_speed * speed_ratio
	linear_velocity = direction * speed
