extends Area2D

@onready var balloon = $"/root/IngameScene/Balloon"

var velocity = Vector2()

func _physics_process(delta: float) -> void:
	
	position.y += balloon.risingSpeed*delta
	position += velocity*delta




func _on_body_entered(body: Node2D) -> void:
	if(body == balloon):
		$"/root/IngameScene".restart_game()
