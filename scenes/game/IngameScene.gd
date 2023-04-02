extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var scoreLabel = $UI/Score

#как сказал великий MaxMorfiX, первый код всегда будет говнокодом

var isGameRestarting = false

var score = 0

func _ready() -> void:
	fade_overlay.visible = true
	
	max_score = SaveGame.load_game_value() || 0.00
	
	pause_overlay.game_exited.connect(_save_game)
	
	new_game()

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true
		
func _save_game() -> void:
	SaveGame.save_game_value(max_score)

func new_game():
	score = 0
	scoreLabel.text = "Score: " + str(score)
	$Balloon.new_game()
	$ObstaclesSpawner.new_game()
	$ScoreTimer.start()

func add_score():
	score += 0.07
	score = round(score*1000)/1000
	scoreLabel.text = "Score: " + str(score)
	
func restart_game():
	
	isGameRestarting = true
	
	for n in $Obstacles.get_children():
		$Obstacles.remove_child(n)
		n.queue_free()
		
	$ScoreTimer.stop()
	$ObstaclesSpawner.stop_game()
	
	fade_overlay.fade_out()



func _on_fade_overlay_on_complete_fade_out() -> void:
	if(isGameRestarting):
		fade_overlay.fade_in()


func _on_fade_overlay_on_complete_fade_in() -> void:
	if(isGameRestarting):
		new_game()
