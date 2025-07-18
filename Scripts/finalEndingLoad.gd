extends Node2D


@onready var endingData = {}
@onready var endingPath = "res://FinalEndings/endingEx.json"
@onready var itemsBackpack:Array


func _ready() -> void:
	endingData = loadEnding(endingPath)
	
	
func loadEnding(JsonPath):
	if FileAccess.file_exists(JsonPath):
		
		var dataFile = FileAccess.open(JsonPath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Array:
			return parsedResult
		print("Error reading endings file!")	
			
	else:
		print("Endings file doesn't exist!")


func updateEndingUnlocked(arrayOfEndingIds:Array):
	for endId in arrayOfEndingIds:
		var id_int := int(endId)
		print("Checking ending ID:", id_int)
		print("Current saved endings:", SaveNLoad.endingUnlocked)

		if id_int in SaveNLoad.endingUnlocked:
			print("Already unlocked:", id_int)
		else:
			print("New ending! Adding:", id_int)
			SaveNLoad.endingUnlocked.append(id_int)
			
