extends Area2D

@onready var balloon = $"/root/IngameScene/Balloon"

var gravityScale = 100

var velocity = Vector2()

func _physics_process(delta: float) -> void:
	
	velocity.y += gravityScale*delta
	
	position.y += balloon.risingSpeed*delta
	position += velocity*delta


func _on_body_entered(body: Node2D) -> void:
	if(body == balloon):
		$"/root/IngameScene".restart_game()


func _on_jump_timer_timeout() -> void:
	velocity.y = -70
	$JumpTimer.wait_time = randf_range(0.5, 1)
	$JumpTimer.start()
