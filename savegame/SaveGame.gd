# Script that manages saving games.
class_name SaveGame extends Node

static func save_game_value(data: float, filename: String = "gamesave.sav") -> void:
	var save_game = FileAccess.open("user://" + filename, FileAccess.WRITE)

	# JSON provides a static method to serialized JSON string.
	var string = str(data)

	# Store the save dictionary as a new line in the save file.
	save_game.store_line(string)
	
static func load_game_value(filename: String = "gamesave.sav"):
	if not FileAccess.file_exists("user://savegame.save"):
		print("no game save!!!")
		return 0.00

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open("user://" + filename, FileAccess.READ)
	if(save_game):
		var string = save_game.get_line()
		return float(string)
	
	return 0.00
