extends Node

@export var ThunderCloudScene: PackedScene
@export var BirdScene: PackedScene
@onready var obstacles = $"/root/IngameScene/Obstacles"

func _ready() -> void:
	$ThunderCloudsTimer.start()
	$BirdTimer.start()

func createThunderCloud() -> void:
	
	$ThunderCloudsTimer.start()
	
	# Create a new instance of the cloud scene.
	var cloud = ThunderCloudScene.instantiate()

	# Choose a random location on Path2D.
	var cloud_spawn_location = $ThunderCloudsPath/ThunderCloudsSpawnLocation
	
	cloud_spawn_location.progress_ratio = randf()

	# Set the cloud's direction perpendicular to the path direction.
	var direction = cloud_spawn_location.rotation + PI / 2

	# Set the cloud's position to a random location.
	cloud.position = cloud_spawn_location.position
	cloud.velocity.x = randf_range(30.0, -30.0)
	
	# Spawn the cloud by adding it to the Main scene.
	obstacles.add_child(cloud)


func new_game():
	$ThunderCloudsTimer.start()
	$BirdTimer.start()


func _on_score_timer_timeout() -> void:
	$ThunderCloudsTimer.wait_time = 100/($"/root/IngameScene".score + 10)
	$BirdTimer.wait_time = 50/($"/root/IngameScene".score + 10)
#	print("time left: ", $ThunderCloudsTimer.time_left)
#	print("wait time: ", $ThunderCloudsTimer.wait_time)
#	print("score: ", $"/root/IngameScene".score)


func createBird() -> void:
	$BirdTimer.start()
	
	# Create a new instance of the bird scene.
	var bird = BirdScene.instantiate()

	# Choose a random location on Path2D.
	var bird_spawn_location = $BirdPath/BirdSpawnLocation
	
	bird_spawn_location.progress_ratio = randf()

	# Set the bird's direction perpendicular to the path direction.
	var direction = bird_spawn_location.rotation + PI / 2

	# Set the bird's position to a random location.
	bird.position = bird_spawn_location.position
	
	if(bird.position.x > 300):
		bird.velocity.x = -40
	else:
		bird.velocity.x = 40
	
	# Spawn the bird by adding it to the Main scene.
	obstacles.add_child(bird)
