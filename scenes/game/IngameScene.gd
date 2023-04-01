extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var scoreLabel = $UI/Score

var score = 0

func _ready() -> void:
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)
	
	new_game()

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())

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
	for n in $Obstacles.get_children():
		$Obstacles.remove_child(n)
		n.queue_free()
	new_game()
