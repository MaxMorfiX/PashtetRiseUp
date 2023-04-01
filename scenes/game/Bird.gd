extends Area2D

@onready var balloon = $"/root/IngameScene/Balloon"

var gravityScale = 100

var velocity = Vector2()

var t = 0

func _physics_process(delta: float) -> void:
	
	velocity.y = cos(t*0.01)*40
	print(velocity.y)
	
	position.y += balloon.risingSpeed*delta
	position += velocity*delta
	
	if(position.y > 1000):
		get_parent().remove_child(self)
		queue_free()
		
	t += 1


func _on_body_entered(body: Node2D) -> void:
	if(body == balloon):
		$"/root/IngameScene".restart_game()
