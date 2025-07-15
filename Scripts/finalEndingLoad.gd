extends Node2D


@onready var endingData = {}
@onready var endingPath = "res://FinalEndings/endingEx.json"


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
