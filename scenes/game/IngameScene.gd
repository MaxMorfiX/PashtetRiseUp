extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var scoreLabel = $UI/Score
@onready var maxScoreLabel = $UI/MaxScore

#как сказал великий MaxMorfiX, первый код всегда будет говнокодом

var isGameRestarting = false

var score = 0
var maxScore = 0

func _ready() -> void:
	fade_overlay.visible = true
	
	new_game()

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true
		
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
	
	if score > maxScore:
		maxScore = score
		maxScoreLabel.text = "Max Score: " + str(maxScore)
	
func restart_game():
	
	isGameRestarting = true
	
	$Balloon.isLocked = true
		
	$ScoreTimer.stop()
	$ObstaclesSpawner.stop_game()
	
	fade_overlay.fade_out()



func _on_fade_overlay_on_complete_fade_out() -> void:
	if(isGameRestarting):
		
		for n in $Obstacles.get_children():
			$Obstacles.remove_child(n)
			n.queue_free()
		
		$Balloon.isLocked = false
		fade_overlay.fade_in()


func _on_fade_overlay_on_complete_fade_in() -> void:
	if(isGameRestarting):
		new_game()
