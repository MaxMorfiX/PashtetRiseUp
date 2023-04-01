extends Node

@export var ThunderCloudScene: PackedScene

@onready var obstacles = $"/root/IngameScene/Obstacles"

func _ready() -> void:
	$ThunderCloudsTimer.start()

func createThunderCloud() -> void:
	# Create a new instance of the cloud scene.
	var cloud = ThunderCloudScene.instantiate()

	# Choose a random location on Path2D.
	var cloud_spawn_location = $ObstaclesPath/ObstaclesSpawnLocation
	
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
