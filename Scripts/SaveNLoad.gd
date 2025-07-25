extends Node

class_name SaveLoad

const SAVE_PATH := "user://save_data.tres"
@onready var save_data: SaveData

var endingUnlocked: Array = []
var firstTime: bool = true
#var blablablba:=

func _ready():
	load_game()
	if endingUnlocked:
		print(save_data.endingUnlocked)
	
func save_game():
	save_data = SaveData.new()
	save_data.endingUnlocked = endingUnlocked
	save_data.firstTime = firstTime
	#save_data.blablabla = blablabla

	var err = ResourceSaver.save(save_data, SAVE_PATH)
	if err != OK:
		print("Error saving game: ", err)
	else:
		print("Game saved!")
		

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found, creating Save_game()")
		save_game()

	var loaded = load(SAVE_PATH)
	if loaded is Resource:
		save_data = loaded
		endingUnlocked = save_data.endingUnlocked.map(func(x): return int(x))
		firstTime = save_data.firstTime
		print("Loaded endings:", SaveNLoad.endingUnlocked)
	else:
		print("Invalid save file format.")
