extends Node

class_name SaveLoad

const SAVE_PATH := "user://save_data.tres"
@onready var save_data: SaveData

var endingUnlocked: Array = []
var tutorialCompleted: bool = false
#var blablablba:=

func _ready():
	load_game()
	if endingUnlocked:
		print(save_data.endingUnlocked)
	if tutorialCompleted:
		print("Skipping Tutorial: ", save_data.tutorialCompleted)
	
func save_game():
	save_data = SaveData.new()
	save_data.endingUnlocked = endingUnlocked
	save_data.tutorialCompleted = tutorialCompleted
	#save_data.blablabla = blablabla

	var err = ResourceSaver.save(save_data, SAVE_PATH)
	if err != OK:
		print("Error saving game: ", err)
	else:
		print("Game saved!")
		

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found.")
		return

	var loaded = load(SAVE_PATH)
	if loaded is Resource:
		save_data = loaded
		endingUnlocked = save_data.endingUnlocked.map(func(x): return int(x))
		tutorialCompleted = save_data.tutorialCompleted
		print("Loaded endings:", SaveNLoad.endingUnlocked)
	else:
		print("Invalid save file format.")
